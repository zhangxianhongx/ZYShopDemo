//
//  MyShopListViewController.swift
//  ZYShopping
//
//  Created by zhangxianhonog on 17/5/13.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class MyShopListViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var pagesize:Int?;
    var dataArray:Array<Dictionary<String,Any>>?;
    var _tableView:UITableView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false;
        self.title = "已发布";
        self.automaticallyAdjustsScrollViewInsets = false;
        _tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64));
        _tableView?.delegate = self;
        _tableView?.dataSource = self;
        self.view.addSubview(_tableView!);
       
        
        _tableView?.tableFooterView = UIView.init();
        pagesize = 30;
        
        let mjheader = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh));
        
        _tableView?.mj_header = mjheader;
        
        let mj_footer = MJRefreshBackStateFooter.init(refreshingTarget: self, refreshingAction: #selector(upRefresh));
        _tableView?.mj_footer = mj_footer;
        
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
    
    //dataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray == nil {
            return 0;
        }
        return (dataArray?.count)!;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "homeCell");
        if cell == nil {
            cell = Bundle.main.loadNibNamed("HomeListTableViewCell", owner: nil, options: nil)?.last as! HomeListTableViewCell?;
        }
        let ce = cell as! HomeListTableViewCell?
        ce?.setDataDic(dic: (self.dataArray?[indexPath.row])!);
        return ce!;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let viewC = HomeInfoViewController.init();
        viewC.animationType = .roundAnimation;
        viewC.hidesBottomBarWhenPushed = true;
        let dic = self.dataArray?[indexPath.row];
        viewC.dataDic = dic;
        self.navigationController?.pushViewController(viewC, animated: true);
        
    }
    //设置tableView可编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    //设置编辑样式为删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete;
    }
    //点击删除执行的方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let dic = self.dataArray?[indexPath.row];
        let shop_id = dic?["objectId"] as! String;
        CoreWork.deleteHistoryShop(shop_id: shop_id) { (respons) in
            
            self.loadData();
        }
        
        
    }
    func loadData(){
       
        let user_id = UserDefaults.standard.object(forKey: "ID") as! String;
        CoreWork.getHistoryShop(userid: user_id) { (respons) in
            self._tableView?.mj_footer.endRefreshing();
            self._tableView?.mj_header.endRefreshing();
            if respons is Dictionary<String,Any>{
                let dic = respons as! Dictionary<String,Any>;
                if Int(dic["code"] as! String) != 200{
                    self.showAlerController(title: "请求失败", message: "请重试");
                    return;
                }
                let dic1 = dic["info"] as! Dictionary<String,Any>;
                let arr = dic1["results"] as! Array<Dictionary<String,Any>>;
                self.dataArray = arr;
                
                //延迟调用
                let delay = DispatchTime.now() + 0.1;
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    self._tableView?.reloadData();
                    
                };
                
                
                
            }else{
                self.showAlerController(title: "请求失败", message: "请重试");
            }

        }
        
    }
    


}
