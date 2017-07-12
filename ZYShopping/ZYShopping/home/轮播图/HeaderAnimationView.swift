//
//  HeaderAnimationView.swift
//  MyPlayer
//
//  Created by ybon on 2016/11/14.
//  Copyright © 2016年 zxh. All rights reserved.
//

import UIKit

class HeaderAnimationView: UIView {
    var _scroller : UIScrollView?;
    var dataArray : Array<Dictionary<String,Any>>?;
    var timer:Timer?;
    var j = 0;
    override init(frame: CGRect) {
        super.init(frame: frame);
        
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatSubViewS(){
        timer?.invalidate();
        _scroller?.removeFromSuperview();
        _scroller = nil;
        _scroller = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height));
       
        _scroller?.isPagingEnabled = true;
        _scroller?.bounces = false;
        _scroller?.showsVerticalScrollIndicator = false;
        _scroller?.showsHorizontalScrollIndicator = false;
        self.addSubview(_scroller!);
        _scroller?.contentSize = CGSize.init(width: self.width*CGFloat((dataArray?.count)!), height: self.height);
        var i = 0;
        for object in dataArray!{
            let dic = object ;
            
            let imageV = ZYImageView.init(frame: CGRect.init(x:CGFloat(i) * self.width, y: 0, width: self.width, height: self.height));
           
            let url =  dic["imgUrl"] as! String;
            imageV.sd_setImage(with: URL.init(string: url));
            _scroller?.addSubview(imageV);
            

            let htmlUrl = dic["url"] as! String;
            imageV.url = htmlUrl;
            
            i = i + 1;
        }
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction(time:)), userInfo: nil, repeats: true);
        
    }
    func timerAction(time:Timer){
    
        j = j + 1;
        if j >= (dataArray?.count)!{
            j = 0;
        }
        UIView.animate(withDuration: 0.35) { 
            
           self._scroller?.contentOffset = CGPoint.init(x: CGFloat(self.j)*self.width, y: 0);
        };
       
        
    }
    
    
    func loadData(){
       
        CoreWork.gethomeHeaderList { (responsObject) in
            
            if responsObject is Dictionary<String,Any>{
                let dic1 = responsObject as! Dictionary<String,Any>;
                
                if Int(dic1["code"] as! String) == 200{
                    let dic2 = dic1["info"] as! Dictionary<String,Any>;
                    let array = dic2["results"] as! Array<Dictionary<String,Any>>;
                    self.dataArray = array;
                    
                    //延迟调用
                    let delay = DispatchTime.now() + 0.1 ;
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.creatSubViewS();
                    };
                    
                }
            }
            
        }
        
    }

    
    
}
