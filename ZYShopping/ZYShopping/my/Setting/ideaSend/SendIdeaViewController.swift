//
//  SendIdeaViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/10.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class SendIdeaViewController: BaseViewController {

    @IBOutlet weak var textV: UITextView!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.layer.cornerRadius = 6;
        sendBtn.layer.borderWidth = 1;
        sendBtn.layer.borderColor = UIColor.lightGray.cgColor;
        sendBtn.layer.masksToBounds = true;
        textV.layer.cornerRadius = 6;
        textV.layer.masksToBounds = true;
       
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        let vc = self.navigationController?.popViewController(animated: true);
        print(vc);
    }

    @IBAction func senBtnAction(_ sender: UIButton) {
        textV.resignFirstResponder();
        if textV.text == ""{
            self.showAlerController(title: "信息内容错误", message: "请正确填写");
            return;
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在提交...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.upIdeaFeedBack(message: textV.text! as String, send_id: UserDefaults.standard.object(forKey: "ID") as! String) { (anyobject) in
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
