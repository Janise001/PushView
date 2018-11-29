//
//  MakeMultiAudioController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/12.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class MakeMultiAudioController: UIViewController {
    /// 话筒设置
    let microPhoneButton: ButtonView = ButtonView(backgroundColor: Color.clear, backgroundImage: UIImage(named: "audio_microphone_icon"), selectedBackgroundImage: UIImage(named: "audio_stop_icon"))
    /// 会话
    var session = AVAudioSession.sharedInstance()
    /// 信息输出
    var fileOutput: AVAudioRecorder?
    /// 音频状态(默认为停止状态)
    var status: CurrentStatus = .end
    /// 保存路径
    var url:URL?
    /// 录音文件列表
    let recoderListView: RecorderFileListTableView = RecorderFileListTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.view.addSubview(self.microPhoneButton)
        self.view.addSubview(self.recoderListView)
        self.microPhoneButton.addTarget(self, action: #selector(audioOperation), for: .touchUpInside)
        self.setupSession()
        self.reloadFilesView()
    }
    /// 设置会话
    func setupSession() {
        do {
            try self.session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }catch {
            print("类型设置失败\(error.localizedDescription)")
        }
        do {
            try self.session.setActive(true)
        }catch {
            print("初始化失败\(error.localizedDescription)")
        }
    }
    /// 音频录制操作
    @objc func audioOperation() {
        self.microPhoneButton.isSelected = !self.microPhoneButton.isSelected
        switch self.status {
        case .start:
            self.status = .end
            // 停止信息输出、停止会话
            self.stop()
            break
        case .end:
            self.status = .start
            self.start()
            break
        }
    }
    /// 开始录音
    func start() {
        //设置保存路径
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/\(Date()).wma")
        let fileUrl = URL(fileURLWithPath: filePath ?? "")
        //设置
        let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 16000),//采样率
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式
            AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
            AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
        ]
        do {
            self.fileOutput = try AVAudioRecorder(url: fileUrl, settings: recordSetting)
            self.fileOutput!.prepareToRecord()
            self.fileOutput!.record()
        }catch {
            print("开启失败\(error.localizedDescription)")
        }
        self.url = fileUrl
    }
    /// 停止录音
    func stop() {
        if let recorder = self.fileOutput {
            //如有需求必要此处加上录音状态判断,无论在不在录音状态都停止录音
//            if recorder.isRecording {
//
//            }else {
//
//            }
            self.fileOutput!.stop()
            //此处重置,文件名称为日期显示，每次新建文件需要更新
            self.fileOutput = nil
            self.reloadFilesView()
        }
    }
    /// 获取app录音文件，刷新录音文件展示列表
    func reloadFilesView() {
        let manager = FileManager.default
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        do {
            let fileNames = try manager.contentsOfDirectory(atPath: documentDirectory ?? "")
            var models: [AudioModel] = []
            fileNames.forEach { (name) in
                let model: AudioModel = AudioModel()
                let path = "\(documentDirectory!)/\(name)"
                model.fileName = name
                model.filePath = path
                models.append(model)
            }
            self.recoderListView.modelData = models
        }catch {
            print("\(error.localizedDescription)")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.microPhoneButton.frame = CGRect(x: self.view.bounds.width/2-50, y: 80, width: 100, height: 100)
        self.recoderListView.frame = CGRect(x: 20, y: 220, width: self.view.bounds.width-40, height: self.view.bounds.height-220)
    }
}

