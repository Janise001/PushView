//
//  AudioActionView.swift
//  PushView
//  单个录音的处理视图
//  Created by 吴丽娟 on 2018/11/19.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class AudioActionView: UIView {

    /// 取消保存拍摄内容按钮
    lazy var cancelButton: ButtonView = ButtonView(backgroundColor: Color.clear, backgroundImage: UIImage(named: "video_cancel_icon"))
    /// 保存拍摄内容按钮
    lazy var sureButton: ButtonView = ButtonView(backgroundColor: Color.clear, backgroundImage: UIImage(named: "video_sure_icon"))
    var operateStackView: UIStackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.5
        self.layer.cornerRadius = 5
        self.backgroundColor = Color.black
        operateStackView = {
            let view = UIStackView()
            view.addArrangedSubview(cancelButton)
            view.addArrangedSubview(sureButton)
            view.axis = .horizontal
            view.alignment = .center
            view.distribution = .equalCentering
            view.spacing = 100
            return view
        }()
        operateStackView.frame = CGRect(x: 20, y: 0, width: frame.width-40, height: frame.height)
        self.addSubview(operateStackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
