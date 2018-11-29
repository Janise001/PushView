//
//  ToolsController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/9.
//  Copyright © 2018年 Janise. All rights reserved.
//
import UIKit
import Photos
import AVKit
/// 变更时间显示
func timeString(_ seconds: Int) -> String {
    //小时显示
    let hour = seconds/3600
    //分钟显示
    let minute = seconds%3600/60
    //秒数显示
    let second = seconds%60
    return String(format: "%02d", hour)+":"+String(format: "%02d", minute)+":"+String(format: "%02d", second)
}

/// 保存指定位置的视频到系统相册
func saveVideoToAlbum(_ url: URL){
    //此处流程未定，暂定为同步保存至系统相册
    PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)}) { (suceess, error) in
        if suceess {
            print("保存至本地相册成功！")
        } else {
            print("保存至本地相册失败！\(error.debugDescription)")
        }
    }
}

/// 播放指定位置的视频文件
///
/// - Parameters:
///   - url: 文件位置
///   - controller: 指定控制器
func playTheVideo(_ url: URL, controller: UIViewController) {
    let player = AVPlayer(url: url)
    let playerController = AVPlayerViewController()
    playerController.player = player
    controller.present(playerController, animated: true, completion: { playerController.player?.play() })
}
/// 音频操作
///
/// - start: 开始录制音频
/// - end: 停止录制音频
enum CurrentStatus {
    case start
    case end
}
func deleteFileFromPath(_ path: URL){
    let manager = FileManager.default
    try! manager.removeItem(at: path)
}
