//
//  RecorderCell.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class RecorderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configLayout()
    }
    //播放标志
    lazy var playButton: ButtonView = ButtonView(backgroundImage: UIImage(named: "audio_play_icon"), selectedBackgroundImage: UIImage(named: "audio_stop_icon"), fontSize: 0)
    var fileNameLabel: LabelView = LabelView(text: "录音文件名")
    func configLayout() {
        self.addSubview(playButton)
        playButton.frame = CGRect(x: 20, y: 10, width: 30, height: 30)
        self.addSubview(fileNameLabel)
        fileNameLabel.frame = CGRect(x: 70, y: 10, width: Int(self.bounds.width-80), height: 30)
        self.playButton.tag = 100
        self.fileNameLabel.tag = 200
        self.playButton.isSelected = self.isSelected
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
