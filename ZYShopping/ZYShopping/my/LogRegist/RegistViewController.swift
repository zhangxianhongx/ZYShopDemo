//
//  RegistViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class RegistViewController: BaseViewController {

    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var pwd: UITextField!
    
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册";
        self.view.layer.masksToBounds = true;
        login.layer.cornerRadius = 6;
        login.layer.borderWidth = 1;
        login.layer.borderColor = UIColor.lightGray.cgColor;
        login.layer.masksToBounds = true;

    }
    

    @IBAction func registBtnAction(_ sender: UIButton) {
        name.resignFirstResponder();
        phone.resignFirstResponder();
        pwd.resignFirstResponder();
        if name.text == "" || phone.text == "" || pwd.text == "" {
            self.showAlerController(title: "信息不完整", message: "请填写完整信息");
            return;
        }
        if phone.text?.validateMobile() == false{
            self.showAlerController(title: "手机号格式不正确", message: "");
            return;
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在注册...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.regist(name: name.text!, phone: phone.text!, password: pwd.text!) { (responsObject) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
            };
            if responsObject is Dictionary<String,Any>{
                let dic = responsObject as! Dictionary<String,Any>;
                if Int(dic["code"] as! String) == 200{
                    let dic1 = dic["info"] as! Dictionary<String,Any>;
                    UserDefaults.standard.set(dic1["objectId"], forKey: "ID");
                   
                    EMClient.shared().register(withUsername:UserDefaults.standard.object(forKey: "ID") as? String , password: "xh123789", completion: { (message, error) in
                        
                        //延迟调用
                        let delay = DispatchTime.now() + 0.1 ;
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            let vc = self.navigationController?.popViewController(animated: true);
                            print(vc);
                        };
                    })
                    
                    
                    
               
                }else{
                    self.showAlerController(title: "请求失败", message: "手机号或已被注册");
                }
                
            }else{
                self.showAlerController(title: "请求失败", message: "请检查网络");
            }

        }
        
    }
   
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        let vc = self.navigationController?.popViewController(animated: true);
        print(vc);
    }
    

}
