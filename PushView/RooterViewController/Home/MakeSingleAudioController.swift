//
//  MakeSingleAudioController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/19.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import AVFoundation
class MakeSingleAudioController: UIViewController {
    

    /// 麦克风按钮
    let microphoneButton: ButtonView = ButtonView(backgroundColor: Color.clear, backgroundImage: UIImage(named: "audio_microphone_icon"), selectedBackgroundImage: UIImage(named: "audio_stop_icon"))
    /// 多媒体会话
    let session = AVAudioSession.sharedInstance()
    /// 文件输出
    var recorder: AVAudioRecorder?
    /// 计时工具
    var timer: Timer?
    /// 计时显示
    var timeLabel: LabelView = LabelView(text: "00:00:00", textColor: Color.black, backgroundColor: Color.clear, fontSize: 16, alignment: .center)
    /// 秒计数
    var seconds: Int = 0
    /// 当前状态
    var status: CurrentStatus = .end
    /// 文件路径
    var filePath: URL?
    /// 处理视图
    var actionView: AudioActionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.view.addSubview(self.microphoneButton)
        self.microphoneButton.addTarget(self, action: #selector(operation(_:)), for: .touchUpInside)
        self.view.addSubview(self.timeLabel)
        self.actionView = AudioActionView(frame: CGRect(x: 20, y: 400, width: self.view.bounds.width-40, height: 100))
        self.view.addSubview(self.actionView!)
        self.actionView!.isHidden = true
        self.actionView?.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    /// 初始化会话
    func setSession() {
        do {
            try self.session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }catch {
            print("会话类型设置失败\(error.localizedDescription)")
        }
        do {
            try self.session.setActive(true)
        }catch {
            print("初始化失败\(error.localizedDescription)")
        }
    }
    /// 录音操作事件
    @objc func operation(_ sender:ButtonView) {
        sender.isSelected = !sender.isSelected
        switch self.status {
        case .start:
            self.stop()
        case .end:
            self.start()
        }
    }
    /// 开始录音
    func start() {
        self.status = .start
        // 开始计时
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showTime), userInfo: nil, repeats: true)
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/\(Date()).wma")
        let url = URL(fileURLWithPath: path ?? "")
        self.filePath = url
        //设置
        let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 16000),//采样率
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式
            AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
            AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
        ]
        do {
            self.recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            self.recorder?.prepareToRecord()
            self.recorder?.record()
        }catch {
            print("录音开启失败\(error.localizedDescription)")
        }
    }
    /// 结束录音
    func stop() {
        //改变记录状态
        self.status = .end
        //重置计时器、计时秒数
        self.resetTimer()
        //输出通道停止并置空
        self.recorder?.stop()
        self.recorder = nil
        self.actionView!.isHidden = false
        self.microphoneButton.isUserInteractionEnabled = false
    }
    /// 时间展示
    @objc func showTime() {
        self.seconds += 1
        self.timeLabel.text = timeString(seconds)
    }
    /// 操作视图中的取消按钮事件
    @objc func cancel() {
        self.microphoneButton.isUserInteractionEnabled = true
        self.actionView?.isHidden = true
        guard let url = self.filePath else { return }
        deleteFileFromPath(url)
        self.resetTimer()
        self.timeLabel.text = timeString(seconds)
    }
    /// 操作视图中的确认保存按钮事件
    @objc func sureAndSave() {
        guard let filePathURL = self.filePath else { return }
        #if Beta
        let playSingleAudioVC = PlaySingleAudioController()
        playSingleAudioVC.config(filePathURL)
        self.navigationController?.pushViewController(playSingleAudioVC, animated: true)
        #endif
    }
    /// 录制时长展示设置
    func resetTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.seconds = 0
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.microphoneButton.frame = CGRect(x: self.view.bounds.width/2-100, y: 100, width: 200, height: 200)
        self.timeLabel.frame = CGRect(x: self.view.bounds.width/2-100, y: 350, width: 200, height: 20)
        
    }
}
