//
//  MakeVedioController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/8.
//  Copyright © 2018年 Janise. All rights reserved.
//


import UIKit
import AVFoundation
import AVKit
import Photos

class MakeVedioController: UIViewController,AVCaptureFileOutputRecordingDelegate {
    
    
    /// 视频捕捉会话
    var videoSession = AVCaptureSession()
    /// 拍摄展示框
    var actionViewLayer: AVCaptureVideoPreviewLayer?
    /// 视频录入（摄像头）
    var camera: AVCaptureDevice?
    /// 音频录入（麦克风）
    var audio = AVCaptureDevice.default(for: .audio)
    /// 工具栏
    var toolView: VideoToolsView = VideoToolsView()
    /// 操作栏
    var operationView: VideoActionView?
    /// 拍摄动作参数（默认为未操作）
    var actionParam: ShootType = ShootType.noShoot
    /// 拍摄视频输出
    var fileOut = AVCaptureMovieFileOutput()
    /// 计时工具
    var timer: Timer?
    /// 时间
    var seconds: Int = 0
    /// 保存路径
    var fileOutPath: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        //初始化拍摄会话
        setSession()
        self.toolView.frame.size = CGSize(width: 200, height: 50)
        self.toolView.frame.origin = CGPoint(x: self.view.bounds.width/2-100, y: 50)
        self.view.addSubview(self.toolView)
        self.toolView.changeSideButton.addTarget(self, action: #selector(changeCurrentDeviceSide), for: .touchUpInside)
        self.toolView.flashButton.addTarget(self, action: #selector(changeFlash), for: .touchUpInside)
        let operationFrame = CGRect(x: 0, y: self.view.bounds.height-100, width: self.view.bounds.width, height: 100)
        self.operationView = VideoActionView(frame: operationFrame)
        self.view.addSubview(self.operationView ?? UIView())
        self.operationViewKitHidden()
        self.operationViewActions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoSession.stopRunning()
    }
    
    /// 初始化设置会话
    func setSession() {
        //设置初始摄像头
        camera = chooseDeviceSize(position: AVCaptureDevice.Position.back)
        //设置清晰度调节
        self.videoSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        //视频录入
        if let videoInput = try? AVCaptureDeviceInput(device: camera!) {
            self.videoSession.addInput(videoInput)
        }
        //音频录入
        if self.audio != nil,let audioDevice = try? AVCaptureDeviceInput(device: audio!) {
            self.videoSession.addInput(audioDevice)
        }
        //设置输出
        self.videoSession.addOutput(fileOut)
        //设置展示框
        self.setLayer()
        self.videoSession.startRunning()
    }
    /// 选择摄像头
    ///
    /// - Parameter position: 摄像头位置（前/后）
    /// - Returns: 摄像设备（摄像头）
    func chooseDeviceSize(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let sides = AVCaptureDevice.devices(for: AVMediaType.video)
        for side in sides {
            if side.position == position {
                return side
            }
        }
        return nil
    }
    /// 初始化展示框
    func setLayer() {
        let vedioLayer = AVCaptureVideoPreviewLayer(session: self.videoSession)
        vedioLayer.frame = self.view.bounds
        vedioLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(vedioLayer)
        actionViewLayer = vedioLayer
    }
    /// 变换摄像头
    @objc func changeCurrentDeviceSide() {
        //设置按钮选中状态，停止摄影会话
        self.toolView.changeSideButton.isSelected = !self.toolView.changeSideButton.isSelected
        self.videoSession.stopRunning()
        //移除视频和麦克风输入
        for input in self.videoSession.inputs {
            self.videoSession.removeInput(input)
        }
        //执行切换摄像头动画
        self.changeDeviceSideTransition()
        //重新将视频和麦克风输入
        if self.audio != nil ,let audioInput = try? AVCaptureDeviceInput(device: audio!) {
            self.videoSession.addInput(audioInput)
        }
        if self.toolView.changeSideButton.isSelected {
            self.camera = chooseDeviceSize(position: .front)
            //设置前置摄像头时必须将闪光灯关闭
            self.toolView.flashButton.isSelected = false
        }else {
            self.camera = chooseDeviceSize(position: .back)
        }
        if let camera = try? AVCaptureDeviceInput(device: camera!) {
            self.videoSession.addInput(camera)
        }
    }
    /// 变换闪光灯
    @objc func changeFlash() {
        //如摄像头当前为前摄像头，return
        if self.camera?.position == AVCaptureDevice.Position.front {
            return
        }
        //后摄像头模式
        let torchMode = self.camera?.torchMode
        if torchMode == AVCaptureDevice.TorchMode.on {
            //关闭失败情况
            do {
                try self.camera?.lockForConfiguration()     //闪光灯使用必须获得设备独占所有权
            }catch{
                print("关闭闪光灯失败")
            }
            self.camera?.torchMode = AVCaptureDevice.TorchMode.off
            self.camera?.flashMode = AVCaptureDevice.FlashMode.off
        }else {
            do {
                try? self.camera?.lockForConfiguration()
            }catch {
                print("开启闪光灯失败")
            }
            self.camera?.torchMode = AVCaptureDevice.TorchMode.on
            self.camera?.flashMode = AVCaptureDevice.FlashMode.on
        }
        self.camera?.unlockForConfiguration()
        self.toolView.flashButton.isSelected = !self.toolView.flashButton.isSelected
        
    }
    /// 设置摄像头翻转时的动画
    func changeDeviceSideTransition() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.delegate = self
        transition.type = "oglFlip" //非公开动画可直接写成字符串格式
        transition.subtype = kCATransitionFromRight
        self.actionViewLayer?.add(transition, forKey: "changeAnimate")
    }
    /// 操作视图中的操作按钮是否隐藏
    func operationViewKitHidden() {
        let param = self.actionParam
        switch param {
        case .noShoot,.shoot:
            self.operationView?.operateStackView.isHidden = true
            self.operationView?.actionButton.isHidden = false
        case .stopShoot:
            self.operationView?.operateStackView.isHidden = false
            self.operationView?.actionButton.isHidden = true
        }
    }
    func operationViewActions() {
        //拍摄按钮
        self.operationView?.actionButton.addTarget(self, action: #selector(videoOperation), for: .touchUpInside)
        //取消按钮（当前拍摄状态为停止状态时设置为未操作状态，隐藏cancelButton和sureButton视图）
        self.operationView?.cancelButton.addTarget(self, action: #selector(cancelFun), for: .touchUpInside)
        //确认按钮（设置当前拍摄状态为未操作状态）
        self.operationView?.sureButton.addTarget(self, action: #selector(sureFun), for: .touchUpInside)
    }
    @objc func videoOperation() {
        //判断当前拍摄状态
        let type = self.actionParam
        //未拍摄状态->变更为拍摄状态（隐藏cancelButton和sureButton视图），开始计时，视频编码输出，变更拍摄按钮点击状态
        if type == .noShoot {
            self.startVideo()
            self.toolView.isHidden = true
        }else if type == .shoot {
            //拍摄中状态->变更为停止状态（显示cancelButton和sureButton视图），计时器停止计时，编码输出停止，变更拍摄按钮点击状态
            self.stopVideo()
            self.toolView.isHidden = true
        }
    }
    /// 拍摄视频
    func startVideo(){
        //开始计时，修改显示时间，开启会话，设置保存位置，开启视频编码输出
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeShowTime), userInfo: nil, repeats: true)
        self.actionParam = .shoot
        self.operationView?.actionButton.isSelected = true
        self.videoSession.startRunning()
        //设置保存路径
        let manager = FileManager.default
        let path = manager.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = path[0].absoluteString
        let index = documentDirectory.index(documentDirectory.startIndex, offsetBy: 7)
        documentDirectory = documentDirectory.substring(from: index)
        let filePath = "\(documentDirectory)\(Date()).mp4"
        let fileUrl = URL(fileURLWithPath: filePath)
        self.fileOut.startRecording(to: fileUrl, recordingDelegate: self)
    }
    /// 停止拍摄视频
    func stopVideo() {
        self.actionParam = .stopShoot
        self.operationView?.actionButton.isSelected = false
        self.toolView.flashButton.isSelected = false
        operationViewKitHidden()
        self.timer?.invalidate()
        self.timer = nil
        self.seconds = 0
        self.videoSession.stopRunning()
        self.fileOut.stopRecording()
    }
    /// 取消按钮方法
    @objc func cancelFun() {
        self.actionParam = .noShoot
        self.seconds = 0
        self.toolView.timeLabel.text = timeString(self.seconds)
        operationViewKitHidden()
        self.videoSession.startRunning()
        self.toolView.isHidden = false
        //删除拍摄的视频
        guard let filePath = fileOutPath else { return }
        deleteFileFromPath(filePath)
    }
    /// 确认按钮方法
    @objc func sureFun() {
        guard let url = self.fileOutPath else { return }
        playTheVideo(url,controller: self)
        saveVideoToAlbum(url)
    }
    /// 时间变化
    @objc func changeShowTime() {
        //计算时长，在保存或者取消的时候重新置为0
        self.seconds += 1
        self.toolView.timeLabel.text = timeString(self.seconds)
    }
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        
    }
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("视频路径："+outputFileURL.absoluteString)
        self.fileOutPath = outputFileURL
    }
}
extension MakeVedioController : CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        //摄像头变换动画之行后开启会话，不将这句放在changeCurrentDeviceSide方法中，
        self.videoSession.startRunning()
    }
    /// 拍摄状态类型
    ///
    /// - noShoot: 未拍摄
    /// - shoot: 拍摄中
    /// - stopShoot: 停止拍摄
    enum ShootType {
        case noShoot
        case shoot
        case stopShoot
    }
}

