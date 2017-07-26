//
//  ShopCommentTableViewCell.swift
//  ZYShopping
//
//  Created by zhangxianhonog on 17/7/9.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ShopCommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageV.layer.cornerRadius = 6;
        imageV.layer.masksToBounds = true;

        commentLabel.numberOfLines = 0;

        
    }
    func setDataDic(dic:Dictionary<String,Any>){
        let url =  dic["comentImg"] as! String;
        imageV.sd_setImage(with: URL.init(string: url ));
        nameLabel.text = dic["commentName"] as! String?;
        timeLabel.text = dic["createdAt"] as! String?;
        commentLabel.text = dic["comentText"] as! String?;
        
    }
   
    
    
}
