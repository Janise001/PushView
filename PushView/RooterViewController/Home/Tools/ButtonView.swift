//
//  ButtonView.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/16.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class ButtonView: UIButton {

    convenience init(title:String = "",
                     titleColor:UIColor = Color.white,
                     backgroundColor:UIColor = Color.tinColor,
                     backgroundImage:UIImage? = nil,
                     selectedBackgroundImage:UIImage? = nil,
                     fontSize:CGFloat = 16,
                     inset:UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10),
                     tag:Int = 0) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        if let image = backgroundImage {
            self.setBackgroundImage(image, for: .normal)
        }
        if let selectedImage = selectedBackgroundImage {
            self.setBackgroundImage(selectedImage, for: .selected)
        }
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize ?? 0)
        self.contentEdgeInsets = inset
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
