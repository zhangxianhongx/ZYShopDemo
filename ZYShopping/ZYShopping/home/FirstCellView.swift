//
//  FirstCellView.swift
//  ZYShopping
//
//  Created by zhangxianhonog on 17/7/8.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class FirstCellView: UIView {

    var _dataArray:Array<Dictionary<String,Any>>?;
    
    func setDataArray(dataArray:Array<Dictionary<String,Any>>){
        
        for subV in self.subviews{
            subV.removeFromSuperview();
        }
        
        _dataArray = dataArray;
        
        let scrollView = UIScrollView.init(frame: self.bounds);
      
        scrollView.contentSize = CGSize.init(width: CGFloat(110 * dataArray.count + 10), height: self.bounds.size.height);
        self.addSubview(scrollView);
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.showsHorizontalScrollIndicator = false;
        for i in 0..<dataArray.count{
            let x = 110 * i + 10;
            let btn = UIButton.init(type: .custom);
            btn.frame = CGRect.init(x: x, y: 5, width: 100, height: Int(self.bounds.size.height));
            btn.tag = 2017 + i;
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside);
            scrollView.addSubview(btn);
            
            let imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: btn.bounds.size.width, height: 100));
            imageV.contentMode = .scaleAspectFit;
            let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: imageV.bottom, width: btn.bounds.size.width, height: 30));
            let priceLabel = UILabel.init(frame: CGRect.init(x: 0, y: titleLabel.bottom, width: btn.bounds.size.width, height: 30));
            titleLabel.textAlignment = NSTextAlignment.center;
            priceLabel.textAlignment = NSTextAlignment.center;
            btn.addSubview(imageV);
            btn.addSubview(titleLabel);
            btn.addSubview(priceLabel);
            let dic = dataArray[i];
            let url =  dic["imgUrl"] as! String;
            imageV.sd_setImage(with: URL.init(string: url ));
            titleLabel.text = dic["shop_name"] as! String?;
            
            if dic["price"] != nil{
                priceLabel.text = String.init(format: "￥%@", (dic["price"] as! String?)!);
            }
            
        }
        
    }
    func btnAction(btn:UIButton){
        let i = btn.tag - 2017;
        
         let viewC = HomeInfoViewController.init();
         viewC.animationType = .roundAnimation;
         viewC.hidesBottomBarWhenPushed = true;
         let dic = self._dataArray?[i];
         viewC.dataDic = dic;
        self.zytviewController()?.navigationController?.pushViewController(viewC, animated: true);
 

    }
    
    
}
