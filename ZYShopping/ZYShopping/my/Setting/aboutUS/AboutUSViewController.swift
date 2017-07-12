//
//  AboutUSViewController.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/10.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class AboutUSViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    

    @IBAction func backBtnAction(_ sender: UIButton) {
        let vc = self.navigationController?.popViewController(animated: true);
        print(vc);
    }
   
    

}
