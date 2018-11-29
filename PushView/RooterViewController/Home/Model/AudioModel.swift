//
//  AudioModel.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import Foundation
class AudioModel {
    var fileName: String?
    var filePath:String?
    var playStatus:PlayStatus = .stop
    /// 播放器播放状态
    ///
    /// - play: 在播放状态
    /// - pause: 暂停中
    /// - stop: 未播放状态
    enum PlayStatus {
        case play
        case pause
        case stop
    }
}
