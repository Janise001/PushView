//
//  ProductViewController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/8/29.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import FlexLayout
class ProductViewController: UIViewController {

    var flexView:UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.flexView)
        let blueView:UIView = UIView()
        blueView.backgroundColor = Color.blue
        let redView:UIView = UIView()
        redView.backgroundColor = Color.red
        let yellowView:UIView = UIView()
        yellowView.backgroundColor = Color.yellow
//        self.flexView.flex.direction(.row)
//        self.flexView.flex.marginTop(100)
//        self.flexView.flex.addItem(blueView).width(100).height(100)
//        self.flexView.flex.addItem(redView).width(100).height(100)
//        self.flexView.flex.addItem(yellowView).width(100).height(100)

        self.flexView.flex.direction(.row).justifyContent(.end).marginTop(100).define { (flex) in
            flex.addItem(blueView).width(100).height(100)
            flex.addItem(redView).width(100).height(100)
            flex.addItem(yellowView).width(100).height(100)
        }


        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexView.frame = self.view.bounds
        self.flexView.flex.layout()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
