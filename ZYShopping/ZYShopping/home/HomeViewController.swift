//
//  HomeViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    var headerView : HeaderAnimationView?;
    var pagesize:Int?;
    var dataArray:Array<Dictionary<String,Any>>?;
    var sectionDataArray:Array<Dictionary<String,Any>>?;
    var _tableView:UITableView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页";
        self.automaticallyAdjustsScrollViewInsets = false;
        _tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64-49), style:.grouped);
        _tableView?.delegate = self;
        _tableView?.dataSource = self;
        self.view.addSubview(_tableView!);
        headerView = HeaderAnimationView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 150));
        _tableView?.tableHeaderView = headerView;
        
        _tableView?.tableFooterView = UIView.init();
        pagesize = 30;
        
        let mjheader = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh));
        
        _tableView?.mj_header = mjheader;
        
//        let mj_footer = MJRefreshBackStateFooter.init(refreshingTarget: self, refreshingAction: #selector(upRefresh));
//        _tableView?.mj_footer = mj_footer;
        refresh();
    }
    
    
    
    func refresh(){
        pagesize = 30;
        self.loadData();
        self.loadSectionData();
    }
    func upRefresh(){
//        pagesize = pagesize! + 30;
//        self.loadData();
    }
  
    //dataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = UIView.init(frame:CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40));
        hView.backgroundColor = UIColor.clear;
        
        let lineView = UIView.init(frame:CGRect.init(x: 5, y: 5, width: 1, height: 30));
        lineView.backgroundColor = UIColor.orange;
        hView.addSubview(lineView);
        let textLabel = UILabel.init(frame:CGRect.init(x: 10, y: 0, width: 200, height: hView.bounds.size.height));
        hView.addSubview(textLabel);
        if section == 0{
            textLabel.text = "最新商品";
        }else{
            textLabel.text = "最新活动";
        }
        let btn = UIButton.init(type: .custom);
        btn.frame = CGRect.init(x: hView.bounds.size.width - 100, y: 0, width: 100, height: hView.bounds.size.height);
        btn.setTitle("查看更多 >", for: .normal);
        btn.setTitleColor(UIColor.black, for: .normal);
        btn.addTarget(self, action: #selector(loockMoreBtnAction(btn:)), for: .touchUpInside);
        btn.tag = section;
        hView.addSubview(btn);
        return hView;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 160;
        }
        return 106;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        if dataArray == nil {
            return 0;
        }
        return 1;
        }
        if sectionDataArray == nil {
            return 0;
        }
        return (sectionDataArray?.count)!;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "aCell");
        var firstCell = tableView.dequeueReusableCell(withIdentifier: "firstCell");
        if indexPath.section == 0 {
            if firstCell == nil{
                firstCell = UITableViewCell.init(style: .default, reuseIdentifier: "firstCell");
                let cellView = FirstCellView.init(frame:CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 170));
                cellView.tag = 201701;
                firstCell?.addSubview(cellView);
            }
            let cellView = firstCell?.viewWithTag(201701) as! FirstCellView;
            cellView.setDataArray(dataArray: self.dataArray!);
            
            return firstCell!;
        }
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ZYActivTableViewCell", owner: nil, options: nil)?.last as! ZYActivTableViewCell?;
        }
        let ce = cell as! ZYActivTableViewCell?
        ce?.setDataDic(dic: (self.sectionDataArray?[indexPath.row])!);
        return ce!;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
      
                
    }
    func loockMoreBtnAction(btn:UIButton){
        if btn.tag == 1{
            let ViewC = HeartViewController();
            ViewC.animationType = .revolveAnimation;
            ViewC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(ViewC, animated: true);
        }else{
            let ViewC = AllShopListViewController();
            ViewC.animationType = .revolveAnimation;
            ViewC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(ViewC, animated: true);
        }
    }
    func loadData(){
        CoreWork.gethomeList(pageSize: String.init(format: "%d", pagesize!)) { (respons) in
//            self._tableView?.mj_footer.endRefreshing();
            self._tableView?.mj_header.endRefreshing();
            if respons is Dictionary<String,Any>{
                let dic = respons as! Dictionary<String,Any>;
                if Int(dic["code"] as! String) != 200{
                    
                    self.showAlerController(title: "请求失败", message: "请重试");
                    return;
                }
                let dic2 = dic["info"] as! Dictionary<String,Any>;
                let arr = dic2["results"] as! Array<Dictionary<String,Any>>;
                self.dataArray = arr;
                
                //延迟调用
                let delay = DispatchTime.now() + 0.1;
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    self._tableView?.reloadData();
                    self.headerView?.loadData();
                };
                
                
                
            }else{
                self.showAlerController(title: "请求失败", message: "请重试");
            }

            
        }
   
    }
    
    func loadSectionData(){
        CoreWork.getActivList(pageSize: String.init(format: "%d", pagesize!)) { (respons) in
//            self._tableView?.mj_footer.endRefreshing();
            self._tableView?.mj_header.endRefreshing();
            if respons is Dictionary<String,Any>{
                let dic = respons as! Dictionary<String,Any>;
                if Int(dic["code"] as! String) != 200{
                    
                    self.showAlerController(title: "请求失败", message: "请重试");
                    return;
                }
                let dic2 = dic["info"] as! Dictionary<String,Any>;
                let arr = dic2["results"] as! Array<Dictionary<String,Any>>;
                self.sectionDataArray = arr;
                
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
