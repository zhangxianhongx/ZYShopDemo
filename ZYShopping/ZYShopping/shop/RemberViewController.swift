//
//  RemberViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class RemberViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商友";
        self.automaticallyAdjustsScrollViewInsets = false;
        let tabl = SFriedListTableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64-49), style: .plain);
        self.view.addSubview(tabl);
        
    }

   
    

}
