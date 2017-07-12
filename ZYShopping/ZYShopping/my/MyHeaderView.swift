//
//  MyHeaderView.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class MyHeaderView: UIView {

    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        imgV.layer.cornerRadius = 50;
        imgV.layer.borderColor = UIColor.white.cgColor;
        imgV.layer.borderWidth = 2;
        imgV.layer.masksToBounds = true;
        self.layer.masksToBounds = true;
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(_:)));
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTouchesRequired = 1;
        imgV.addGestureRecognizer(tap);
        
    }
    
    func tapAction(_ tap: UITapGestureRecognizer) {
        
        let viewC = LoginViewController.init(nibName:"LoginViewController",bundle:nil);
        viewC.hidesBottomBarWhenPushed = true;
        viewC.animationType = .revolveAnimation;
        self.viewController().navigationController?.pushViewController(viewC, animated: true);
    }
    
    
}
