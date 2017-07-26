//
//  HomeInfoHeaderView.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/12.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class HomeInfoHeaderView: UIView {
    var dataDic:Dictionary<String,Any>?;
    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var personDesc: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var imgBgview: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBOutlet weak var qqBtn: UIButton!
    
    var imgChiceView:ZYSkimImgCollectionView?;
    override func awakeFromNib() {
        super.awakeFromNib();
        headerImg.layer.cornerRadius = 4;
        headerImg.layer.masksToBounds = true;
        
        
    }
    func setDataDic(dic:Dictionary<String,Any>){
        dataDic = dic;
        let url =  dataDic?["imgUrl"] as! String;
        headerImg.sd_setImage(with: URL.init(string:  url ));
        name.text = dataDic?["shop_name"] as! String?;
        descLabel.text = dataDic?["desc"] as! String?;
        priceLabel.text = String.init(format: "￥%@", (dataDic?["price"] as! String?)!);
        timeLabel.text = dataDic?["updatedAt"] as! String?;
        personDesc.text = String.init(format: "发布者：%@", (dataDic?["publis_name"] as! String?)!);
        phoneBtn.setTitle(dataDic?["phone"] as! String?, for: .normal);
        qqBtn.setTitle(dataDic?["qq"] as! String?, for: .normal);
        imgChiceView = ZYSkimImgCollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init());
        imgChiceView?.backgroundColor = UIColor.clear;
        imgBgview.addSubview(imgChiceView!);
        
        loadData();
    }
    func loadData(){
 
        CoreWork.getShopImagList(shopid: dataDic?["objectId"] as! String) { (respons) in
            if respons is Dictionary<String,Any>{
                let dic = respons as! Dictionary<String,Any>;
                if Int(dic["code"] as! String) != 200{
                   
                    return;
                }
                let dic1 = dic["info"] as! Dictionary<String,Any>;
                let arr = dic1["results"] as! Array<Dictionary<String,Any>>;
                var imgArr:Array<String> = Array.init();
                for dic in arr{
                    let url = dic["url"] as! String;
                    let allurl = url;
                    imgArr.append(allurl);
                }
                //延迟调用
                let delay = DispatchTime.now() + 0.1;
                DispatchQueue.main.asyncAfter(deadline: delay) {
                   
                    //238
                    let desc = self.dataDic?["desc"] as! String;
                    let size = desc.sizeWithFontMaxSize(font: UIFont.systemFont(ofSize: 15), maxSize: CGSize.init(width: self.descLabel.width, height: CGFloat(MAXFLOAT)));
                    let imgSize = CommentConfig.imageSize(withImgCount: arr.count, imgItemSize: CGSize.init(width: (kScreenWidth-30)/3, height: (kScreenWidth-30)/3+10));
                    self.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 238 + size.height + imgSize.height);
                    self.imgChiceView?.frame = self.imgBgview.bounds;
                    self.imgChiceView?.imageArray = imgArr;
                    if (self.superview != nil){
                        let tab = self.superview as! UITableView;
                        tab.tableHeaderView = self;
                    }
                    
                };
                
                
                
            }
            
            
        }
        
        
    }
    
    
    @IBAction func phoneBtnAction(_ sender: UIButton) {
         let phone = (phoneBtn.titleLabel?.text)! as String
            let phoneStr = "tel:" + phone;
        if UIApplication.shared.canOpenURL(URL(string: phoneStr)!) {
            
            UIApplication.shared.open(URL(string: phoneStr)!, options: [:], completionHandler: {(sucess) in })
            
            
        }else{
            
            print("failed to tel")
        }
    }
    
    
    @IBAction func qqBtnAction(_ sender: UIButton) {
        
        let QQid = (qqBtn.titleLabel?.text)! as String
        let urlPath = URL(string: "mqq://im/chat?chat_type=wpa&uin=\(QQid)&version=1&src_type=web")
        
//        let QQGroup = "537476189"
//        let urlGroup = URL(string: "mqq://im/chat?chat_type=group&uin=\(QQGroup)&version=1&src_type=web")
  
        if UIApplication.shared.canOpenURL(URL(string: "mqq://")!) {
//qq单聊
                UIApplication.shared.open(urlPath!, options: [:], completionHandler: {(sucess) in })
       //qq群聊
//                UIApplication.shared.open(urlGroup!, options: [:], completionHandler: {(sucess) in })
   
        }else{

            print("failed to open qq")
        }
    }

    
    
    @IBAction func cheatOnline(_ sender: UIButton) {
        
        if UserDefaults.standard.object(forKey: "ID") != nil{
            
            let viewC = CheatViewController.init(conversationChatter: dataDic?["pubLiser_id"]  as! String, conversationType: EMConversationTypeChat);
            viewC?.title = dataDic?["publis_name"] as! String?;
            let url =  dataDic?["imgUrl"] as! String;
            viewC?.sendImgUrl = url;
            if UserDefaults.standard.object(forKey: "img") != nil{
                viewC?.selfImgUrl = UserDefaults.standard.object(forKey: "img") as! String;
            }
            
            self.viewController().navigationController?.pushViewController(viewC!, animated: true);
            
        }
        
    }
    
}
