//
//  LoginViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    
    @IBOutlet weak var phoneTextF: UITextField!
    
    @IBOutlet weak var pwdTextF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录";
        self.view.layer.masksToBounds = true;
        loginBtn.layer.cornerRadius = 6;
        loginBtn.layer.borderWidth = 1;
        loginBtn.layer.borderColor = UIColor.lightGray.cgColor;
        loginBtn.layer.masksToBounds = true;
        
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        phoneTextF.resignFirstResponder();
        pwdTextF.resignFirstResponder();
        if  phoneTextF.text == "" || pwdTextF.text == "" {
            self.showAlerController(title: "信息不完整", message: "请填写完整信息");
            return;
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在登录...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.login(phone: phoneTextF.text!, password: pwdTextF.text!) { (responsObject) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
            };
            if responsObject is Dictionary<String,Any>{
                let dic1 = responsObject as! Dictionary<String,Any>;
                
                if Int(dic1["code"] as! String) == 200{
                    let dic = dic1["info"] as! Dictionary<String,Any>;
                    //延迟调用
                    let delay = DispatchTime.now() + 0.1 ;
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        
                        UserDefaults.standard.set(dic["objectId"], forKey: "ID");
                        UserDefaults.standard.set(dic["img"], forKey: "img");
                        
                        UserDefaults.standard.set(dic["phoneNum"], forKey: "phoneNum");
                        UserDefaults.standard.set(self.pwdTextF.text! as String, forKey: "password");
                        UserDefaults.standard.set(dic["username"], forKey: "name");
                        UserDefaults.standard.set(dic["desc"], forKey: "desc");
                        let username = UserDefaults.standard.object(forKey: "name");
                        let password = UserDefaults.standard.object(forKey: "password");
                        BmobUser.loginInbackground(withAccount: username as! String!, andPassword: password as! String!) { (user, error) in
                            
                        }
                        EMClient.shared().login(withUsername: UserDefaults.standard.object(forKey: "ID") as? String, password: "xh123789", completion: { (userName, error) in
                            
                            let vc = self.navigationController?.popViewController(animated: true);
                            print(vc);
                        });
                        
                    };
                    
                    
                }else{
                    self.showAlerController(title: "请求失败", message: "账号或密码错误");
                }
                
            }else{
                self.showAlerController(title: "请求失败", message: "请检查网络");
            }

            
    
        }
        
    }

    @IBAction func registBtnaction(_ sender: UIButton) {
        let viewC = RegistViewController.init(nibName:"RegistViewController",bundle:nil);
        viewC.hidesBottomBarWhenPushed = true;
        viewC.animationType = .roundAnimation;
        self.navigationController?.pushViewController(viewC, animated: true);
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
       let vc = self.navigationController?.popViewController(animated: true);
        print(vc);
    }

}
