//
//  AppDelegate.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        self.window?.backgroundColor = UIColor.white;
        self.window?.makeKeyAndVisible();
        BaseTabBarController.changeKeyWindowRootViewController();
        
        let options = EMOptions.init(appkey: "zhangxianhong#banghai");
        EMClient.shared().initializeSDK(with: options);
        
        if UserDefaults.standard.object(forKey: "ID") as? String != nil{
            EMClient.shared().login(withUsername: UserDefaults.standard.object(forKey: "ID") as? String, password: "xh123789", completion: { (userName, error) in
                
                
            });
        }
        //私人账号信息，仅限于次项目中使用，若有需要，请前去Bmob官网查看文档
        Bmob.register(withAppKey: "6d20735124371b40efda63779b2741f8");
        if UserDefaults.standard.object(forKey: "name") == nil ||  UserDefaults.standard.object(forKey: "password") == nil{
            return true;
        }
        let username = UserDefaults.standard.object(forKey: "name") as! String;
        let password = UserDefaults.standard.object(forKey: "password") as! String;
       
        BmobUser.loginInbackground(withAccount: username, andPassword: password ) { (user, error) in
            
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        EMClient.shared().applicationDidEnterBackground(application);
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        EMClient.shared().applicationWillEnterForeground(application);
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}

