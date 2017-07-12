//
//  SFriendListTableViewCell.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/10.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class SFriendListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgV.layer.cornerRadius = 4;
        imgV.layer.masksToBounds = true;
        
        
    }
    func setDataDic(dic:Dictionary<String,Any>){
        
        if dic["img"] != nil && dic["img"] as! String != ""{
            imgV.sd_setImage(with: URL.init(string: String.init(format: "%@",dic["img"] as! CVarArg)));
        }
        nameLabel.text = dic["username"] as! String?;
        descLabel.text = dic["desc"] as! String?;
        
    }
    
}
