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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
