//
//  HeartViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class HeartViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    var pagesize:Int?;
    var dataArray:Array<Dictionary<String,Any>>?;

    var _tableView: UITableView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "娱乐";
        self.automaticallyAdjustsScrollViewInsets = false;
        _tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-64-49));
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "aCell");
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ZYActivTableViewCell", owner: nil, options: nil)?.last as! ZYActivTableViewCell?;
        }
        let ce = cell as! ZYActivTableViewCell?
        ce?.setDataDic(dic: (self.dataArray?[indexPath.row])!);
        return ce!;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
//        let viewC = HeaderInfoViewController.init(nibName:"HeaderInfoViewController",bundle:nil);
//        viewC.animationType = .flipOverAnimation;
//        let dic = (self.dataArray?[indexPath.row])! as Dictionary<String,Any>;
//        viewC.url = dic["infoUrl"] as! String?;
//        self.navigationController?.pushViewController(viewC, animated: true);
        
        
    }
    
    func loadData(){
        CoreWork.getActivList(pageSize: String.init(format: "%d", pagesize!)) { (respons) in
            self._tableView?.mj_footer.endRefreshing();
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
                };
                
                
                
            }else{
                self.showAlerController(title: "请求失败", message: "请重试");
            }
            
            
        }
        
    }

   
    

}
