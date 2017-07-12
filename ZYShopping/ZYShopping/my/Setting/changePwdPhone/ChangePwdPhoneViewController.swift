//
//  ChangePwdPhoneViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/10.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ChangePwdPhoneViewController: BaseViewController {

    
    @IBOutlet weak var fLabel: UILabel!
    
    @IBOutlet weak var sLabel: UILabel!
    
    @IBOutlet weak var tLabel: UILabel!
    
    @IBOutlet weak var fTextF: UITextField!
    @IBOutlet weak var sTextF: UITextField!
    
    @IBOutlet weak var tTextF: UITextField!

    @IBOutlet weak var sureBtn: UIButton!
    
    var type:Int?;
    override func viewDidLoad() {
        super.viewDidLoad()
        sureBtn.layer.cornerRadius = 6;
        sureBtn.layer.borderWidth = 1;
        sureBtn.layer.borderColor = UIColor.lightGray.cgColor;
        sureBtn.layer.masksToBounds = true;
      
        if type == 0 {
            self.title = "修改手机号";
            self.fLabel.text = "原手机号:";
            self.sLabel.text = "新手机号:";
            self.tLabel.text = "新手机号:";
            self.fTextF.placeholder = "原手机号";
            self.sTextF.placeholder = "新手机号";
            self.tTextF.placeholder = "确认手机号";
            
        }else{
            self.title = "修改密码";
        }
        
    }
    

    @IBAction func sureBtnAction(_ sender: UIButton) {
        if fTextF.text == "" || tTextF.text == "" || tTextF.text == "" || sTextF.text != tTextF.text {
            self.showAlerController(title: "信息内容错误", message: "请正确填写");
            return;
        }
        if fTextF.text == tTextF.text{
            self.showAlerController(title: "相同的信息不能修改", message: "请正确填写");
            return;
        }
        
        if type == 0 {
            if tTextF.text?.validateMobile() == false {
                self.showAlerController(title: "信息内容错误", message: "请正确填写");
                return;
            }
            let oldphone = UserDefaults.standard.object(forKey: "phoneNum") as! String;
            if fTextF.text! as String != oldphone{
                self.showAlerController(title: "信息内容错误", message: "请正确填写");
                return;
            }
            changePhoneNumber();
        }else{
            let oldpwd = UserDefaults.standard.object(forKey: "password") as! String;
            if fTextF.text! as String != oldpwd{
                self.showAlerController(title: "信息内容错误", message: "请正确填写");
                return;
            }
            changePwd();
        }
    }
    //修改手机号
    func changePhoneNumber(){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在修改...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        
        CoreWork.upUserInfomation(dic: ["phoneNum":sTextF.text! as String,"id":UserDefaults.standard.object(forKey: "ID") as! String,"name":UserDefaults.standard.object(forKey: "name") as! String,"password":UserDefaults.standard.object(forKey: "password") as! String]) { (responsObject) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
            };
            
            
            
            if responsObject is Dictionary<String,Any>{
                let dic1 = responsObject as! Dictionary<String,Any>;
                
                if Int(dic1["code"] as! String) == 200{
                    UserDefaults.standard.set(self.sTextF.text! as String, forKey: "phoneNum");
                    
                    self.showAlerController(title: "更新成功", message: "");
                    
                    //延迟调用
                    let delay = DispatchTime.now() + 0.1 ;
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        let vc = self.navigationController?.popViewController(animated: true);
                        print(vc);
                        
                    };
                }else{
                    self.showAlerController(title: "请求失败", message: "");
                }
                
            }else{
                self.showAlerController(title: "请求失败", message: "");
            }
        }
    }
    //修改密码
    func changePwd(){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在修改...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
       
        CoreWork.upUserInfomation(dic: ["newpassword":tTextF.text! as String,"id":UserDefaults.standard.object(forKey: "ID") as! String,"name":UserDefaults.standard.object(forKey: "name") as! String,"password":UserDefaults.standard.object(forKey: "password") as! String]) { (responsObject) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
            };
            
            
            
            if responsObject is Dictionary<String,Any>{
                let dic1 = responsObject as! Dictionary<String,Any>;
                
                if Int(dic1["code"] as! String) == 200{
                    self.showAlerController(title: "更新成功", message: "");
                    UserDefaults.standard.set(self.sTextF.text! as String, forKey: "password");
                    //延迟调用
                    let delay = DispatchTime.now() + 0.1 ;
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        let vc = self.navigationController?.popViewController(animated: true);
                        print(vc);
                        
                    };
                }else{
                    self.showAlerController(title: "请求失败", message: "");
                }
                
            }else{
                self.showAlerController(title: "请求失败", message: "");
            }
        }
    }
}
