//
//  PlaySingleAudioController.swift
//  PushView
//  播放单个音频文件
//  Created by 吴丽娟 on 2018/11/28.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class PlaySingleAudioController: UIViewController {
    private var filePath: URL?
    func config(_ filePath: URL) {
        self.filePath = filePath
    }
    var progress: ProgressView?
    /// 播放按钮
    var playButton: ButtonView = ButtonView(backgroundColor: Color.clear, backgroundImage: UIImage(named: "audio_play_icon"), selectedBackgroundImage: UIImage(named: "audio_stop_icon"), fontSize: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.playButton)
        self.progress = ProgressView()
        self.progress?.frame = CGRect(x: self.view.bounds.width/2-100, y: 300, width: 200, height: 10)
        self.progress?.fillTintColor = Color.red
        self.progress?.trackTintColor = Color.white
        self.progress?.progress = 0.3
        self.view.addSubview(self.progress ?? ProgressView())
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.playButton.frame = CGRect(x: self.view.bounds.width/2-75, y: 100, width: 150, height: 150)
    }
}
