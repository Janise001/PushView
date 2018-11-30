//
//  ProgressView.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/11/30.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class ProgressView: UIControl {
    
    /// 进度值
    var progress:Float = 0.00 {
        didSet {
            self.progressLayer.progressFloat = progress
            self.progressLayer.setNeedsDisplay()
        }
    }
    /// 宽度
    var width: CGFloat = 0.00 {
        didSet {
          self.progressLayer.width = width
            self.progressLayer.setNeedsDisplay()
        }
    }
    /// 高度
    var height: CGFloat = 0.00 {
        didSet {
            self.progressLayer.height = height
            self.progressLayer.setNeedsDisplay()
        }
    }
    
    /// 未填充部分颜色
    var trackTintColor: UIColor = Color.white {
        didSet {
            self.progressLayer.trackTintColor = trackTintColor
            self.progressLayer.setNeedsDisplay()
        }
    }
    var fillTintColor: UIColor = Color.gray {
        didSet {
            self.progressLayer.fillTintColor = fillTintColor
            self.progressLayer.setNeedsDisplay()
        }
    }
    var progressLayer:ProgressLayer {
        return self.layer as! ProgressLayer
    }
    override class var layerClass: AnyClass {
        return ProgressLayer.self
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.width = frame.width
//        self.height = frame.height
//    }
    
    
}
