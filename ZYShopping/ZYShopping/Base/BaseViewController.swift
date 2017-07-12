//
//  BaseViewController.swift
//  MyPlayer
//
//  Created by z x h  on 2016/10/29.
//  Copyright © 2016年 zxh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  public  override func showAlerController(title:String,message:String) -> Void {
        
        let alertC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        let carmaAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (UIAlertActiono) in
            
            
        }
       
        
        alertC.addAction(carmaAction);
        
        self.present(alertC, animated: true, completion: nil);
    }
}
