//
//  MyViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var myTableView:UITableView?;
    var headerView:MyHeaderView?;
    let arr = ["个人信息","已发布商品","发布商品","清除缓存","意见反馈","关于我们","设置"];
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的";
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = UIColor.white;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-49));
        myTableView?.delegate = self;
        myTableView?.dataSource = self;
        self.view.addSubview(myTableView!);
        
        headerView = Bundle.main.loadNibNamed("MyHeaderView", owner: nil, options: nil)?.last as! MyHeaderView?;
        myTableView?.tableHeaderView = headerView;
        myTableView?.tableFooterView = UIView.init();
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.isHidden = true;
        if UserDefaults.standard.object(forKey: "ID") == nil{
            headerView?.logInBtn.isHidden = false;
            headerView?.imgV.isUserInteractionEnabled = true;
            headerView?.nameLabel.text = "";
            headerView?.descLabel.text = "";
            headerView?.imgV.image = nil;
            return;
        }
        headerView?.imgV.isUserInteractionEnabled = false;
        headerView?.logInBtn.isHidden = true;
       
        headerView?.nameLabel.text = UserDefaults.standard.object(forKey: "name") as! String?;
        headerView?.descLabel.text = UserDefaults.standard.object(forKey: "desc") as! String?;
        if UserDefaults.standard.object(forKey: "img") != nil{
            headerView?.imgV.sd_setImage(with: URL.init(string: String.init(format: "%@",UserDefaults.standard.object(forKey: "img") as! CVarArg)));
        }
        
        
    }
    //dataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell");
        cell.accessoryType = .disclosureIndicator;
        cell.textLabel?.text = arr[indexPath.row];
        return cell;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        if indexPath.row == 0  {
            if UserDefaults.standard.object(forKey: "ID") == nil{
                self.showAlerController(title: "您未登录", message: "请先登录");
            }else{
                let viewC = PersonInfoViewController.init(nibName:"PersonInfoViewController",bundle:nil);
                viewC.userID = UserDefaults.standard.object(forKey: "ID") as! String?;
                viewC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(viewC, animated: true);
            }
            
            
        }
        if indexPath.row == 1 {
            
            if UserDefaults.standard.object(forKey: "ID") == nil{
                self.showAlerController(title: "您未登录", message: "请先登录");
            }else{
                let viewC = MyShopListViewController.init();
                viewC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(viewC, animated: true);
            }

        }
        if indexPath.row == 2{
            self.showAlerController(title: "暂未开放", message: "请期待后期更新");
        }
        if indexPath.row == 3{
            let alertC = UIAlertController.init(title: "你目前缓存" + getCachesSize(), message: "请选择清除", preferredStyle: UIAlertControllerStyle.alert);
            let carmaAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (UIAlertActiono) in
                clearDisk();
            }
            alertC.addAction(carmaAction);
            self.present(alertC, animated: true, completion: nil);
            
        }
        if indexPath.row == 4 {
            if UserDefaults.standard.object(forKey: "ID") == nil{
                self.showAlerController(title: "您未登录", message: "请先登录");
                return;
            }
            let viewC = SendIdeaViewController.init(nibName:"SendIdeaViewController",bundle:nil);
            viewC.animationType = .revolveAnimation;
            viewC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(viewC, animated: true);
            
        }
        if indexPath.row == 5 {
            
            let viewC = AboutUSViewController.init(nibName:"AboutUSViewController",bundle:nil);
            viewC.animationType = .revolveAnimation;
            viewC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(viewC, animated: true);
            
        }
        if indexPath.row == 6{
            if UserDefaults.standard.object(forKey: "ID") == nil{
                self.showAlerController(title: "您未登录", message: "请先登录");
            }else{
                let viewC = MySettingViewController.init(nibName:"MySettingViewController",bundle:nil);
                viewC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(viewC, animated: true);
            }
            
        }
    
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
