//
//  ViewController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/8/28.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("页1 -> viewDidLoad方法")
        //        let imageView1:UIImageView = UIImageView()
        //        let imageView2:UIImageView = UIImageView()
        //        let image1 = UIImage(named: "scenery")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .tile)
        //        imageView1.image = image1
        //        imageView1.frame = CGRect(x: 0, y: 100, width: 300, height: 200)
        //        self.view.addSubview(imageView1)
        //
        //        let image2 = UIImage(named: "scenery")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20), resizingMode: .stretch)
        //        imageView2.image = image2
        //        imageView2.frame = CGRect(x: 0, y: 400, width: 300, height: 200)
        //        self.view.addSubview(imageView2)
        //
        // Do any additional setup after loading the view, typically from a nib.
        
        //        let imageView:UIImageView = UIImageView()
        //        imageView.image = UIImage(named: "scenery")
        //        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        //        let imageShadowView:UIView = UIView()
        //        imageShadowView.frame = CGRect(x: 0, y: 100, width: 200, height: 200)
        //        imageShadowView.addSubview(imageView)
        //        imageShadowView.backgroundColor = UIColor.red
        //        imageShadowView.layer.cornerRadius = 10.0
        //        imageShadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        //        imageShadowView.layer.shadowColor = UIColor.black.cgColor
        //        imageShadowView.layer.shadowOpacity = 1.0
        //        imageShadowView.clipsToBounds = true
        //        self.view.addSubview(imageShadowView)
        
        //        let imageView:UIImageView = UIImageView()
        //        imageView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 300)
        //        imageView.image = UIImage(named: "scenery")
        //        imageView.contentMode = .center
        //        imageView.backgroundColor = UIColor.orange
        //        self.view.addSubview(imageView)
        //
        //        let label1:UILabel = UILabel()
        //        label1.frame = CGRect(x: 0, y: 420, width: 0, height: 0)
        //        label1.font = UIFont.systemFont(ofSize: 10)
        //        label1.text = "calncjanslkdcjnaslkdjcnas"
        //        label1.sizeToFit()
        //        self.view.addSubview(label1)
        //        print(label1.frame.size.width)
        //        print(label1.frame.size.height)
        //
        //        let label2:UILabel = UILabel()
        //        label2.frame = CGRect(x: 0, y: 500, width: 0, height: 0)
        //        label2.font = UIFont.systemFont(ofSize: 10)
        //        label2.text = "calncjanslkdcjnaslkdjcnas"
        //        label2.sizeThatFits(CGSize(width: 50, height: 30))
        //        self.view.addSubview(label2)
        //        print(label2.frame.size.width)
        //        print(label2.frame.size.height)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("页1 -> viewWillAppear方法")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("页1 -> viewDidAppear方法")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("页1 -> viewWillDisappear方法")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("页1 -> viewDidDisappear方法")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

