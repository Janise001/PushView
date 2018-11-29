//
//  RecorderFileListTableView.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class RecorderFileListTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var modelData:[AudioModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    var player:AVAudioPlayer?
//    var playButton:ButtonView = ButtonView()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        //注册cell
        self.register(RecorderCell.self, forCellReuseIdentifier: "recorderCell")
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = Color.white
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recorderCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let playButton:ButtonView = cell.viewWithTag(100) as! ButtonView
        playButton.isHidden = self.modelData[indexPath.row].playStatus == .stop
        playButton.setTitle(String(indexPath.row), for: .normal)
        playButton.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
        let fileName:LabelView = cell.viewWithTag(200) as! LabelView
        fileName.text = self.modelData[indexPath.row].fileName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50
    }
    @objc func playAudio(_ sender: UIButton) {
        guard let index = sender.titleLabel?.text else { return }
        do {
            let path = self.modelData[Int(index)!].filePath ?? ""
            let url = URL(fileURLWithPath: path)
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            let time = player?.duration
            let currentTime = player?.deviceCurrentTime
            if currentTime == 0 {
                player!.play()
            } else if currentTime! - time! < 0 {
                player?.pause()
            } else if currentTime == time {
                player?.play()
            }
        }catch let error {
            print(error.localizedDescription)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var playType = self.modelData[index].playStatus
        switch playType {
        case .play:
            playType = .stop
            
        case .pause:
            playType = .play
            
        case .stop:
            playType = .play
            
        }
    }
}
extension RecorderFileListTableView: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("录音播放完成")
//        self.playButton.isSelected = !self.playButton.isSelected
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(error?.localizedDescription)
    }
    
}
