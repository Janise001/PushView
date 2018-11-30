//
//  ProgressLayer.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/30.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class ProgressLayer: CALayer {

    /// 当前百分比
    var progressFloat: Float = 0.00
    
    /// 进度条中填充部分显示颜色
    var fillTintColor: UIColor = Color.blue {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 进度条中未填充部分显示颜色
    var trackTintColor: UIColor = Color.white {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 进度条高度
    var height: CGFloat = 10
    
    /// 进度条画宽度
    var width: CGFloat = 100
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(self.trackTintColor.cgColor)
        ctx.addRect(CGRect(x: 0, y: 0, width: self.width, height: self.height))
        ctx.fillPath()
    }

}
