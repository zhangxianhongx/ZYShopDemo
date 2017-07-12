//
//  PersonInfoViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/5.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class PersonInfoViewController: BaseViewController {
    
    var userID:String?;
    var btn:UIButton?;
    var imgStr:String?;
    var phone:String?;
    @IBOutlet weak var imgV: ZYEditImageView!
    
    @IBOutlet weak var nameT: UITextField!
    
    @IBOutlet weak var ageT: UITextField!
    
    @IBOutlet weak var sexT: UITextField!
    
    @IBOutlet weak var addrT: UITextField!
    
    @IBOutlet weak var descT: UITextField!
    
    
    @IBOutlet weak var upBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息";
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController?.navigationBar.isHidden = false;
        upBtn.layer.cornerRadius = 6;
        upBtn.layer.borderColor = UIColor.lightGray.cgColor;
        upBtn.layer.borderWidth = 1;
        upBtn.layer.masksToBounds = true;
        imgV.isUserInteractionEnabled = false;
        btn = UIButton.init(type: .custom);
        btn?.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40);
        btn?.setTitle("编辑", for: .normal);
        btn?.setTitle("取消", for: .selected);
        btn?.setTitleColor(UIColor.black, for: .normal);
        btn?.setTitleColor(UIColor.red, for: .selected);
        btn?.addTarget(self, action: #selector(editBtnAction(rightBtn:)), for: .touchUpInside);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn!);
        if userID == UserDefaults.standard.object(forKey: "ID") as? String{
            
            
        }else{
            upBtn.isHidden = false;
            upBtn.setTitle("发消息", for: UIControlState.normal);
            btn?.setTitle("举报", for: .normal);
        }
        
        getInfomation();
    }
    
    //获取用户信息
    func getInfomation(){
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在加载数据...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.getPersonInfo(userID: userID! as String) { (responsObject) in
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
                       
                        if dic["img"] != nil{
                           self.imgV.sd_setImage(with: URL.init(string: String.init(format: "%@",dic["img"] as! CVarArg)));
                        }
                        
                        self.imgStr = dic["img"] as! String?;
                        self.nameT.text = dic["username"] as! String?;
                        if dic["age"] != nil{
                            self.ageT.text = String.init(format: "%@", dic["age"] as! CVarArg);
                        }
                        
                        self.addrT.text = dic["addr"] as! String?;
                        self.descT.text = dic["desc"] as! String?;
                        self.phone = dic["phoneNum"] as! String?;
                        if dic["sex"] != nil{
                            let sex = NSString.init(format: "%@", dic["sex"] as! CVarArg);
                            if sex.intValue == 1{
                                self.sexT.text = "男";
                            }else{
                                self.sexT.text = "女";
                            }
                        }
                        
                    };
                }else{
                    self.showAlerController(title: "请求失败", message: "");
                }
                
            }else{
                self.showAlerController(title: "请求失败", message: "");
            }

            
        }
        
    }
/***********************************************************************/
    @objc private func editBtnAction(rightBtn:UIButton){
        if userID == UserDefaults.standard.object(forKey: "ID") as? String{
            rightBtn.isSelected = !rightBtn.isSelected;
            changeTextFEditing();
            
        }else{
            //进入举报页面
            let viewC = ReportViewController.init(nibName:"ReportViewController", bundle: nil);
            viewC.animationType = .roundAnimation;
            viewC.report_id = userID;
            self.navigationController?.pushViewController(viewC, animated: true);
        }
        
    }
    //改变输入框属性
    func changeTextFEditing(){
        imgV.isUserInteractionEnabled = (btn?.isSelected)!;
//        nameT.isUserInteractionEnabled = (btn?.isSelected)!;
        ageT.isUserInteractionEnabled = (btn?.isSelected)!;
        sexT.isUserInteractionEnabled = (btn?.isSelected)!;
        addrT.isUserInteractionEnabled = (btn?.isSelected)!;
        descT.isUserInteractionEnabled = (btn?.isSelected)!;
        upBtn.isHidden = !(btn?.isSelected)!
    }
    @IBAction func upBtnAction(_ sender: UIButton) {
       if userID != UserDefaults.standard.object(forKey: "ID") as? String{
        
        let viewC = CheatViewController.init(conversationChatter: userID! as String, conversationType: EMConversationTypeChat);
        viewC?.title = self.nameT.text! as String;
        viewC?.sendImgUrl = imgStr;
        if UserDefaults.standard.object(forKey: "img") != nil{
          viewC?.selfImgUrl = UserDefaults.standard.object(forKey: "img") as! String;
        }
        
        self.navigationController?.pushViewController(viewC!, animated: true);
        
       }else{
            upMessage();
        }
    }
    func upMessage(){
        if imgV.image == nil {
            self.showAlerController(title: "用户信息不完整", message: "请添加完整信息");
            return;
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在上传图片...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.upImage(dic: ["image":imgV.image!]) { (object) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
                
                if object is Dictionary<String,Any>{
                    let dic1 = object as! Dictionary<String,Any>;
                    
                    if Int(dic1["code"] as! String) == 200{
                        self.imgStr = dic1["imgUrl"] as! String?;
                        
                        self.upUserInfoMation();
                    }else{
                        self.showAlerController(title: "请求失败", message: "");
                    }
                    
                }else{
                    self.showAlerController(title: "请求失败", message: "");
                }
            };
            
            
        }
        

    }
    //更新用户信息
    func upUserInfoMation(){
        if imgStr == "" || nameT.text == "" || ageT.text == "" || sexT.text == "" || addrT.text == "" || descT.text == ""{
            self.showAlerController(title: "用户信息不完整", message: "请添加完整信息");
            return;
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在更新数据...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        let sexstr = sexT.text! as String;
        var sex = "2";
        if sexstr == "男"{
            sex = "1";
        }
        CoreWork.upUserInfomation(dic: ["img":imgStr! as String,"name":nameT.text! as String,"age":ageT.text! as String,"sex":sex as String,"addr":addrT.text! as String,"desc":descT.text! as String,"id":userID! as String,"password":UserDefaults.standard.object(forKey: "password") as! String]) { (responsObject) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
            };
            
            
            
            if responsObject is Dictionary<String,Any>{
                let dic1 = responsObject as! Dictionary<String,Any>;
                
                if Int(dic1["code"] as! String) == 200{
                    self.showAlerController(title: "更新成功", message: "");
                    UserDefaults.standard.set(self.imgStr, forKey: "img");
                    UserDefaults.standard.set(self.nameT.text! as String, forKey: "name");
                    UserDefaults.standard.set(self.descT.text! as String, forKey: "desc");
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
