//
//  BaseTabBarController.swift
//  MyPlayer
//
//  Created by z x h  on 2016/10/29.
//  Copyright © 2016年 zxh. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    class func changeKeyWindowRootViewController(){
        
        let homeNav = BaseNavigationController.init(rootViewController:HomeViewController.init());
        let remberNav = BaseNavigationController.init(rootViewController:RemberViewController.init());
        let hearNav = BaseNavigationController.init(rootViewController:HeartViewController.init());
        let myNav = BaseNavigationController.init(rootViewController:MyViewController.init());
        
        homeNav.title = "首页";
        remberNav.title = "商友";
        hearNav.title = "娱乐";
        
        myNav.title = "我的";
        homeNav.tabBarItem.image = UIImage.init(named:"分类");
        homeNav.tabBarItem.selectedImage = UIImage.init(named: "分类on")
        hearNav.tabBarItem.image = UIImage.init(named:"专题");
        hearNav.tabBarItem.selectedImage = UIImage.init(named: "专题on")
        remberNav.tabBarItem.image = UIImage.init(named: "附近");
        remberNav.tabBarItem.selectedImage = UIImage.init(named: "附近on");
        myNav.tabBarItem.image = UIImage.init(named:"精选");
        myNav.tabBarItem.selectedImage = UIImage.init(named: "精选on")
        let tabBarController = BaseTabBarController.init();
        tabBarController.viewControllers = [homeNav,remberNav,myNav];
        UIApplication.shared.keyWindow?.rootViewController = tabBarController;
        tabBarController.tabBar.tintColor = UIColor.orange;
        
    }
    
    
}
