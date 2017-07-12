//
//  ZYActivTableViewCell.swift
//  ZYShopping
//
//  Created by zhangxianhonog on 17/5/21.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ZYActivTableViewCell: UITableViewCell {

    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var activName: UILabel!
    
    @IBOutlet weak var activDesc: UILabel!
    
    
    @IBOutlet weak var activUpTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgV.layer.cornerRadius = 4;
        imgV.layer.masksToBounds = true;
        
    }
    func setDataDic(dic:Dictionary<String,Any>){
        
        let url =  dic["imgUrl"] as! String;
        imgV.sd_setImage(with: URL.init(string: url ));
        activName.text = dic["activename"] as! String?;
        activDesc.text = dic["desc"] as! String?;

        activUpTime.text = "发布时间:" + (dic["updatedAt"] as! String?)!;
    }
}
