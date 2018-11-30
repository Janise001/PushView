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
    var playButtonView:ButtonView = ButtonView()
    var indexSelected: Int?
    

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
//        playButton.isHidden = self.modelData[indexPath.row].playStatus == .stop
        playButton.setTitle(String(indexPath.row), for: .normal)
        playButton.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
        let fileName:LabelView = cell.viewWithTag(200) as! LabelView
        fileName.text = self.modelData[indexPath.row].fileName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50
    }
    @objc func playAudio(_ sender: ButtonView) {
        guard let indexStr = sender.titleLabel?.text else {
            return
        }
        let index = Int(indexStr) ?? 0
        self.playButtonView = sender
        sender.isSelected = !sender.isSelected
        self.playButtonView.isSelected = sender.isSelected
        do {
            self.indexSelected = index
            let path = self.modelData[index].filePath ?? ""
            let url = URL(fileURLWithPath: path)
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            let time = player?.duration
            let currentTime = player?.currentTime
            if currentTime == 0 {
                player!.play()
                self.modelData[index].playStatus = .play
            } else if time! > currentTime! && (currentTime!) != 0{
                if self.modelData[index].playStatus == .play {
                    player?.pause()
                    self.modelData[index].playStatus = .pause
                }else if self.modelData[index].playStatus == .pause {
                    player?.play()
                    self.modelData[index].playStatus = .play
                }
            } else if currentTime == time {
                player?.stop()
                self.modelData[index].playStatus = .stop
            }
        }catch let error {
            print(error.localizedDescription)
        }
    }
}
extension RecorderFileListTableView: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("录音播放完成")
        self.playButtonView.isSelected = !self.playButtonView.isSelected
        self.modelData[self.indexSelected ?? 0].playStatus = .stop
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(error?.localizedDescription)
    }
    
}
