//
//  ZYCategory.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/5.
//  Copyright © 2016年 ybon. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    //找到UIView及其子类的跟视图控制器
    func zytviewController() -> UIViewController? {
        var next = self.next;
        
        while next != nil {
            if next is UIViewController {
                return next as? UIViewController;
            }
            next = next?.next;
        }
        
        
        return nil;
    }
    
   
//    public  func showAlerController(title:String,message:String) -> Void {
//        
//        let alertC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
//        let carmaAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (UIAlertActiono) in
//            
//            
//        }
//        
//        
//        alertC.addAction(carmaAction);
//        
//        self.zytviewController()?.present(alertC, animated: true, completion: nil);
//    }
 
    
}
extension UIViewController{
    public  func showAlerController(title:String,message:String) -> Void {
        
        let alertC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        let carmaAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (UIAlertActiono) in
            
            
        }
        
        
        alertC.addAction(carmaAction);
        
        self.present(alertC, animated: true, completion: nil);
    }
    
}
extension String{
   //验证是否是邮箱
    func isEmailWihtemailString()->Bool{
        
        let regix = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regix);
        let isValid = predicate.evaluate(with: self);
        
        return isValid;
    }
    //验证手机号
    func validateMobile()-> Bool{
        if self == "" {
            return false;
        }
       let MU = "^((14[5,7])|(13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,1-9]))\\d{8}$";
        let regextestMU = NSPredicate.init(format: "SELF MATCHES %@", MU);
        if regextestMU.evaluate(with: self) == true {
            return true;
        }else{
            return false;
        }
    }
    //验证身份证
    func validateIdentityCard()->Bool{
        if self == ""{
            return false;
        }
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$";
        let identityCardPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex);
        return identityCardPredicate.evaluate(with: self);
    }
    //判断数字是否为纯数字
    func isPureNumandCharacters()->Bool{
        if self == "" {
            return false;
        }
       let resuStr = self.trimmingCharacters(in: CharacterSet.decimalDigits);
        if resuStr != "" {
            return false;
        }
        return true;
    }
    func sizeWithFontMaxSize(font:UIFont,maxSize:CGSize) -> CGSize{
        let attrs = [NSFontAttributeName : font] as NSDictionary;
        
        
        return self.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs as? [String : AnyObject], context: nil).size;
    }

    
    
}
