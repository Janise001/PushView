//
//  FourFunctionsTestViewController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/8/28.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class FourFunctionsTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("页2 -> viewDidLoad方法")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("页2 -> viewWillAppear方法")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("页2 -> viewDidAppear方法")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("页2 -> viewWillDisappear方法")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("页2 -> viewDidDisappear方法")
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
