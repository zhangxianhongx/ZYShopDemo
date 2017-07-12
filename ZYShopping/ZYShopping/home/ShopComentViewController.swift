//
//  ShopComentViewController.swift
//  ZYShopping
//
//  Created by zhangxianhonog on 17/7/9.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ShopComentViewController: BaseViewController {

    var shopInfoDic:Dictionary<String,Any>?;
    @IBOutlet weak var textV: UITextView!
    
    @IBOutlet weak var pubBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        textV.layer.cornerRadius = 6;
        textV.layer.masksToBounds = true;
        pubBtn.layer.cornerRadius = 6;
        pubBtn.layer.masksToBounds = true;
        pubBtn.layer.borderWidth = 1;
        pubBtn.layer.borderColor = UIColor.lightGray.cgColor;
        
    }
    

   
    @IBAction func pubBtnAction(_ sender: UIButton) {
        let userDefault = UserDefaults.standard;
        if  userDefault.object(forKey: "ID") == nil {
            self.showAlerController(title: "暂未登录", message: "请先登陆");
            return;
        }
        if textV.text.startIndex == textV.text.endIndex {
            self.showAlerController(title: "评论内容为空", message: "");
            return;
        }
      
        var dic = Dictionary<String,String>();
        
        let coment_id = userDefault.object(forKey: "ID") as? String;
        let coment_img = userDefault.object(forKey: "img") as? String;
        let coment_name = userDefault.object(forKey: "name") as? String;
        let coment_text = textV.text;
        let shop_id = shopInfoDic?["objectId"]! as! String;
        
        dic["coment_id"] = coment_id;
        dic["coment_img"] = coment_img;
        dic["coment_name"] = coment_name;
        dic["coment_text"] = coment_text;
        dic["shop_id"] = shop_id;
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在提交...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.addShopComent(dic: dic){ (anyobject) in
            //延迟调用
            let delay = DispatchTime.now() + 0.1 ;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                hud.hide(animated: true);
            };
            if anyobject is Dictionary<String,Any>{
                let dic1 = anyobject as! Dictionary<String,Any>;
                if Int(dic1["code"] as! String) == 200{
                    let delay = DispatchTime.now() + 0.1 ;
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        let vc = self.navigationController?.popViewController(animated: true);
                        print(vc);
                    }
                }
            }
            
            
        }
        
        
        
    }
    

}
