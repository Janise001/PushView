//
//  LabelView.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/16.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class LabelView: UILabel {
    
    convenience init(text:String = "", textColor:UIColor = Color.black, backgroundColor:UIColor = Color.white, fontSize:CGFloat = 16, alignment:NSTextAlignment = .left, tag:Int = 0) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = alignment
        self.tag = tag
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
