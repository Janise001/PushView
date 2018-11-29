//
//  AppDelegate+windows.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/8/29.
//  Copyright © 2018年 Janise. All rights reserved.
//

import Foundation
import UIKit
extension UITabBarController {
    var home : UINavigationController {
        let viewCon = UINavigationController(rootViewController: HomeViewController())
        let tabItem = UITabBarItem(title: "首页", image: UIImage(named: "icon_home_default"), selectedImage: UIImage(named: "icon_home_selected"))
        viewCon.tabBarItem = tabItem
        return viewCon
    }
    var product : UINavigationController {
        let viewCon = UINavigationController(rootViewController: ProductViewController())
        let tabItem = UITabBarItem(title: "产品", image: UIImage(named: "icon_shop_default"), selectedImage: UIImage(named: "icon_shop_selected"))
        viewCon.tabBarItem = tabItem
        return viewCon
    }
    var mine : UINavigationController {
        let viewCon = UINavigationController(rootViewController: MineViewController())
        let tabItem = UITabBarItem(title: "我的", image: UIImage(named: "icon_my_default"), selectedImage: UIImage(named: "icon_my_selected"))
        viewCon.tabBarItem = tabItem
        return viewCon
    }
}

extension AppDelegate {
    
    func configWindow() {
        let window = UIWindow()
        self.window = window
        window.makeKeyAndVisible()
        configNavigation()
    }
    func configNavigation(){
        let tab = UITabBarController()
        let home = tab.home
        let product = tab.product
        let mine = tab.mine
        let tabController = [home,product,mine]
        tab.viewControllers = tabController
        self.window?.rootViewController = tab
    }
}
extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.viewColor
    }
}
