//
//  ActionView.swift
//  PushView
//  拍摄操作栏，包括叉号按钮，拍摄按钮，确认按钮
//  Created by 吴丽娟 on 2018/11/9.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class VideoActionView: UIView {
    /// 取消保存拍摄内容按钮
    lazy var cancelButton: ButtonView = ButtonView(backgroundImage: UIImage(named: "video_cancel_icon"))
    /// 拍摄状态按钮
    lazy var actionButton: ButtonView = ButtonView(backgroundImage: UIImage(named: "video_stop_icon"), selectedBackgroundImage: UIImage(named: "video_start_icon"))
    /// 保存拍摄内容按钮
    lazy var sureButton: ButtonView = ButtonView(backgroundImage: UIImage(named: "video_sure_icon"))
    var operateStackView: UIStackView = UIStackView()
    var shootStackView: UIStackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.5
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
        shootStackView = {
            let view = UIStackView()
            view.addArrangedSubview(actionButton)
            view.axis = .horizontal
            view.alignment = .center
            view.distribution = .equalCentering
            view.spacing = 100
            return view
        }()
        let allStackView: UIStackView = {
            let view = UIStackView()
            view.addArrangedSubview(operateStackView)
            view.addArrangedSubview(shootStackView)
            view.axis = .vertical
            view.alignment = .center
            view.distribution = .equalCentering
            return view
        }()
        allStackView.frame = CGRect(x: 20, y: 0, width: frame.width-40, height: frame.height)
        self.addSubview(allStackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
