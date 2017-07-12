//
//  HomeListTableViewCell.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/12.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var nameLaebl: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgV.layer.cornerRadius = 4;
        imgV.layer.masksToBounds = true;
        imgV.contentMode = .scaleAspectFit;
        
    }
    
    func setDataDic(dic:Dictionary<String,Any>){
        
        let url =  dic["imgUrl"] as! String;
        imgV.sd_setImage(with: URL.init(string: url ));
        nameLaebl.text = dic["shop_name"] as! String?;
        descLabel.text = dic["desc"] as! String?;
        if dic["price"] != nil{
            priceLabel.text = String.init(format: "￥%@", (dic["price"] as! String?)!);
        }
        
        timeLabel.text = dic["updatedAt"] as! String?;
    }
    
}
