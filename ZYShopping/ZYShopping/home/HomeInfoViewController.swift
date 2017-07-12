//
//  HomeInfoViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/12.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class HomeInfoViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    var pagesize:Int?;
    var dataArray:Array<Dictionary<String,Any>>?;
    var dataDic:Dictionary<String,Any>?;
    var headerView:HomeInfoHeaderView?;
    var _tableView:UITableView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情";
        self.view.backgroundColor = UIColor.white;
        self.automaticallyAdjustsScrollViewInsets = false;
        _tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64));
        self.view.addSubview(_tableView!);
        _tableView?.delegate = self;
        _tableView?.dataSource = self;
        _tableView?.backgroundColor = UIColor.init(colorLiteralRed: 235.0/255.0, green: 235.0/255.0, blue: 243.0/255.0, alpha: 1);
        _tableView?.tableFooterView = UIView.init();
        headerView = Bundle.main.loadNibNamed("HomeInfoHeaderView", owner: nil, options: nil)?.last as! HomeInfoHeaderView?;
        headerView?.setDataDic(dic:dataDic!);
        _tableView?.tableHeaderView = headerView;
        
        
        let mjheader = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh));
        
        _tableView?.mj_header = mjheader;
        
        let mj_footer = MJRefreshBackStateFooter.init(refreshingTarget: self, refreshingAction: #selector(upRefresh));
        _tableView?.mj_footer = mj_footer;
        refresh();
 
        let enditBtn = UIButton.init(type: .custom);
        enditBtn.frame = CGRect.init(x: kScreenWidth - 100, y: kScreenHeight - 100, width: 40, height: 40);
        self.view.addSubview(enditBtn);
        enditBtn.addTarget(self, action: #selector(editBtnAction(btn:)), for: .touchUpInside);
        enditBtn.setBackgroundImage(UIImage.init(named: "编辑.png"), for: .normal);
        
    }
    func refresh(){
        pagesize = 30;
        self.getComentList();
    }
    func upRefresh(){
        pagesize = pagesize! + 30;
        self.getComentList();
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray != nil{
            let comentText = dataArray?[indexPath.row]["comentText"] as! String;
            let strSize = comentText.sizeWithFontMaxSize(font: UIFont.systemFont(ofSize: 17), maxSize: CGSize.init(width: kScreenWidth-8, height: 10000));
            return 90 + strSize.height;
        }
        return 90;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray == nil{
            return 0;
        }
        return dataArray!.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ID = "comentCell";
        var cell = tableView.dequeueReusableCell(withIdentifier: ID);
        if cell == nil{
            cell = Bundle.main.loadNibNamed("ShopCommentTableViewCell", owner: nil, options: nil)?.last as! UITableViewCell?;
        }
        let ce = cell as! ShopCommentTableViewCell;
        ce.setDataDic(dic: (dataArray?[indexPath.row])!);
        return ce;
    }
    func getComentList(){
        
        CoreWork.getShopComentList(shop_id: dataDic?["objectId"] as! String,pagesize:String.init(format: "%d", pagesize!)) { (respons) in
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

    //编辑按钮方法
    func editBtnAction(btn:UIButton){
        let ViewC = ShopComentViewController.init(nibName:"ShopComentViewController",bundle:nil);
        ViewC.shopInfoDic = dataDic;
        ViewC.animationType = .flipOverAnimation;
        self.navigationController?.pushViewController(ViewC, animated: true);
    }
    
}
