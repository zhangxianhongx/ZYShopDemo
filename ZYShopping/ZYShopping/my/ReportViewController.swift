//
//  ReportViewController.swift
//  ZYShopping
//
//  Created by zhangxianhonog on 17/5/21.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ReportViewController: BaseViewController {

    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var textV: UITextView!
    
    var report_id:String?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "举报";
        self.automaticallyAdjustsScrollViewInsets = false;
    }


    @IBAction func upBtnActin(_ sender: UIButton) {
        if textV.text == ""{
            self.showAlerController(title: "信息不完整", message: "");
            return;
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在提交...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        CoreWork.reportUser(r_id: (UserDefaults.standard.object(forKey: "ID") as? String)!, rd_id: report_id!, message: textV.text! as String) { (anyobject) in
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
