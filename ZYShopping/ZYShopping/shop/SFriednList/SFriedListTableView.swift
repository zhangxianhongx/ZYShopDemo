//
//  SFriedListTableView.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/10.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class SFriedListTableView: UITableView ,UITableViewDelegate,UITableViewDataSource{
    private var pagesize:Int?;
    private var dataArray:Array<Any>?;
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = UIView.init();
        pagesize = 30;
        dataArray = Array.init();
        let mjheader = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh));
        
        self.mj_header = mjheader;
        
        let mj_footer = MJRefreshBackStateFooter.init(refreshingTarget: self, refreshingAction: #selector(upRefresh));
        self.mj_footer = mj_footer;
        refresh();
    }
    func refresh(){
        pagesize = 30;
        self.loadData();
    }
    func upRefresh(){
        pagesize = pagesize! + 30;
        self.loadData();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //dataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray == nil {
            return 0;
        }
        return (dataArray?.count)!;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "sfcell");
        if cell == nil {
            cell = Bundle.main.loadNibNamed("SFriendListTableViewCell", owner: nil, options: nil)?.last as! SFriendListTableViewCell?;
        }
        let ce = cell as! SFriendListTableViewCell?
        ce?.setDataDic(dic: self.dataArray?[indexPath.row] as! Dictionary<String,Any>);
        return ce!;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        if UserDefaults.standard.object(forKey: "ID") == nil{
            self.viewController().showAlerController(title: "您未登录", message: "请先登录");
        }else{
            let viewC = PersonInfoViewController.init(nibName:"PersonInfoViewController",bundle:nil);
            let dic = self.dataArray?[indexPath.row] as! Dictionary<String,Any>;
            viewC.userID = dic["objectId"] as! String?;
            viewC.animationType = .revolveAnimation;
            viewC.hidesBottomBarWhenPushed = true;
            self.viewController().navigationController?.pushViewController(viewC, animated: true);
        }
        
    }
    
    func loadData(){
        
        CoreWork.getAllFriend(pageSize: String.init(format: "%d", pagesize!)) { (respons) in
            self.mj_footer.endRefreshing();
            self.mj_header.endRefreshing();
            if respons is Dictionary<String,Any>{
                let dic = respons as! Dictionary<String,Any>;
                if Int(dic["code"] as! String) != 200{
                    self.viewController().showAlerController(title: "请求失败", message: "请重试");
                    return;
                }
                let dic1 = dic["info"] as! Dictionary<String,Any>;
                let arr = dic1["results"];
                if arr is Array<Any>{
                    self.dataArray = Array.init();
                    
                    let resultArr = arr as! NSArray;
                    for ddd in resultArr{
                        self.dataArray?.append(ddd);
                        
                    }
                }
                
//                 = arr;
                //延迟调用
                let delay = DispatchTime.now() + 0.1;
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    self.reloadData();
                };
                    
                
                
            }else{
                self.viewController().showAlerController(title: "请求失败", message: "请重试");
            }
            
            
            
        }
        
        
    }
    
    
}
