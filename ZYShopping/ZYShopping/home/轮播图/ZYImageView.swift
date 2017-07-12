//
//  ZYImageView.swift
//  MyPlayer
//
//  Created by ybon on 2016/11/14.
//  Copyright © 2016年 zxh. All rights reserved.
//

import UIKit

class ZYImageView: UIImageView {

    var url:String?;
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.isUserInteractionEnabled = true;
//        self.contentMode = .scaleAspectFit;
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tabpAction));
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        self.addGestureRecognizer(tap);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tabpAction(tap:UITapGestureRecognizer){
        let viewC = HeaderInfoViewController.init(nibName:"HeaderInfoViewController",bundle:nil);
        viewC.url = url;
        viewC.hidesBottomBarWhenPushed = true;
        self.viewController().navigationController?.pushViewController(viewC, animated: true);
        
    }
    
    
}
