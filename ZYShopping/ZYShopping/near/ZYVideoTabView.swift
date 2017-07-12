//
//  ZYVideoTabView.swift
//  搞笑视频
//
//  Created by ybon on 2017/2/23.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ZYVideoTabView: UITableView ,UITableViewDelegate,UITableViewDataSource{
    private var page:Int?;
    private var dataArray:Array<Any>?;
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.dataSource = self;
        self.delegate = self;
        dataArray = Array.init();
        page = 1;
        
        let mjheader = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh));

        self.mj_header = mjheader;
       
//        let mj_footer = MJRefreshBackStateFooter.init(refreshingTarget: self, refreshingAction: #selector(upRefresh));
//        self.mj_footer = mj_footer;
        refresh();
    }
    func refresh(){
        page = 1;
        self.loadData();
    }
    func upRefresh(){
        page = page! + 1;
        self.loadData();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //dataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dic = self.dataArray?[indexPath.section] as! Dictionary<String,Any>;
        let str = dic["text"] as? String;
       let size = str?.sizeWithFontMaxSize(font: UIFont.systemFont(ofSize: 17), maxSize: CGSize.init(width: UIScreen.main.bounds.size.width-16, height: 1000));
        return 197 + (size?.height)!;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    public func numberOfSections(in tableView: UITableView) -> Int{
        if dataArray == nil {
            return 0;
        }
        return (self.dataArray?.count)!;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "cell";
        var cell = tableView.dequeueReusableCell(withIdentifier: ID);
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ZYVideoTableViewCell", owner: nil, options: nil)?.last as! UITableViewCell?;
        }
        let ce = cell as! ZYVideoTableViewCell;
        let dic = self.dataArray?[indexPath.section] as! Dictionary<String,Any>;
        ce.setDataDic(dataDic: dic);
        cell?.selectionStyle = UITableViewCellSelectionStyle.none;
        return cell!;
    }
    //delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ce = tableView.cellForRow(at: indexPath) as! ZYVideoTableViewCell;
        ce.player();
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) != nil {
            
            let ce = tableView.cellForRow(at: indexPath) as! ZYVideoTableViewCell;
            ce.pasuh();
        }
 
    }
    func setDataArray(){
        self.reloadData();
    }
    func loadData(){
         weak var weakSelf = self;
        CoreWork.homeHeaderList(page: String.init(format: "%d", page!)) { (respons) in
//            weakSelf?.mj_footer.endRefreshing();
            weakSelf?.mj_header.endRefreshing();
            
            if respons is Dictionary<String,Any>{
                let dic = respons as! Dictionary<String,Any>;
                let dic1 = dic["showapi_res_body"] as! Dictionary<String,Any>;
                let arr = dic1["data"] ;
                
                if arr is Array<Any>{
                    if self.page == 1{
                        weakSelf?.dataArray = Array.init();
                    }
                    let resultArr = arr as! NSArray;
                    for ddd in resultArr{
                        weakSelf?.dataArray?.append(ddd);
                        
                    }
                    
                    //延迟调用
                    let delay = DispatchTime.now() + 0.1;
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                       self.reloadData();
                    };
                    
                }
                
            }

        }
    }
   
    
}
