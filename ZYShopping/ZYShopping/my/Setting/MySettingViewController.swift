//
//  MySettingViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/5.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class MySettingViewController: BaseViewController  ,UITableViewDelegate,UITableViewDataSource{
    
    var myTableView:UITableView?;


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置";
        self.navigationController?.navigationBar.isHidden = false;
        self.automaticallyAdjustsScrollViewInsets = false;
        myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64));
        myTableView?.delegate = self;
        myTableView?.dataSource = self;
        self.view.addSubview(myTableView!);
        myTableView?.tableFooterView = UIView.init();
        
    }
    
    //dataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell");
        cell.accessoryType = .disclosureIndicator;
        let arr = ["修改手机号","修改密码","退出登录"];
        cell.textLabel?.text = arr[indexPath.row];
        return cell;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if indexPath.row == 2 {
            logout();
        }else{
            let viewC = ChangePwdPhoneViewController.init(nibName:"ChangePwdPhoneViewController",bundle:nil);
            viewC.type = indexPath.row;
            viewC.animationType = .scaleAnimation;
            self.navigationController?.pushViewController(viewC, animated: true);
        }
        
    }

    func logout(){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.mode = MBProgressHUDMode.customView;
        hud.label.text = "正在退出登录...";
        hud.backgroundColor = UIColor.clear;
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor;
        if UserDefaults.standard.object(forKey: "ID") as? String != nil{
           
            EMClient.shared().logout(true, completion: { (error) in
                
                
            });
        }

        //延迟调用
        let delay = DispatchTime.now() + 1 ;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            UserDefaults.standard.removeObject(forKey: "ID");
            UserDefaults.standard.removeObject(forKey: "desc");
            UserDefaults.standard.removeObject(forKey: "img");
            UserDefaults.standard.removeObject(forKey: "name");
            UserDefaults.standard.removeObject(forKey: "phoneNum");
            UserDefaults.standard.removeObject(forKey: "password");
            
            hud.hide(animated: true);
            let vc = self.navigationController?.popViewController(animated: true);
            print(vc);
            
        };
    }
    

}
