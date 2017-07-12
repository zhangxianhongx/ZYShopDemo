//
//  RequestWork.swift
//  NSURLSession
//
//  Created by mac on 16/9/10.
//  Copyright © 2016年 ZY. All rights reserved.
//

import UIKit

class RequestWork: NSObject ,CAAnimationDelegate{

    /**
     GET
     */
    class func zyGETWithURLSession(_ urlString:String,parmas:NSDictionary,mathFunction:@escaping (_ responObject:AnyObject)->Void){
    
        let session = URLSession.shared;
        let str = self.parmasStringWithParmas(parmas);
//        NSString * urlStr = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        let resultstr = str.addingPercentEscapes(using: String.Encoding.utf8);
        let url = URL.init(string: urlString+"?"+resultstr!);
     
        
        let task = session.dataTask(with: url!, completionHandler: { (data, respons, eror) -> Void in
            if data != nil{
                do {
                    try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments);
                    let responsobject = try?JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments);
                    mathFunction(responsobject! as AnyObject);
                } catch {
                    mathFunction("file" as AnyObject);
                }

            }else{
                mathFunction("file" as AnyObject);
            }
            
            
        }) 
        task.resume();
        
    }
    /**
     POST
     */
    class func zyPOSTwithURLSession(_ urlString:String,parmas:NSDictionary,mathFunction:@escaping (_ responObject:AnyObject)->Void){
       
      
        
        let session = URLSession.shared;
        
        let str = self.parmasStringWithParmas(parmas);
        let url = URL(string: urlString);
        
        var request = URLRequest(url: url!);
        
        request.httpMethod = "POST";
        
        request.httpBody = str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        
        
        let task = session.dataTask(with:request, completionHandler: { (data, respons, error) -> Void in
            
            if data != nil{
                do {
                    try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments);
                    let responsobject = try?JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments);
                    mathFunction(responsobject! as AnyObject);
                } catch {
                  mathFunction("file" as AnyObject);
                }
                
            }else{
                mathFunction("file" as AnyObject);
            }
        }) 
        
        task.resume();
    }
    /**
     up data
     */
    class func zyUpwithURLSession(_ urlString:String,parmas:NSDictionary,mathFunction:@escaping (_ responObject:AnyObject)->Void){
        
        
        
        let session = URLSession.shared;
        
        let url = URL(string: urlString);
        
        var request = URLRequest(url: url!);
        
        request.httpMethod = "POST";
        
        let img = UIImage.init(named: "09.jpg");
        let data = UIImageJPEGRepresentation(img!, 0.5);
        let da = data?.base64EncodedData(options: .lineLength64Characters);
        
        
        try!da?.write(to: URL.init(fileURLWithPath: "/Users/ybon/Desktop/121.jpg"));
        let task = session.uploadTask(with: request, from: da) { (resultData, respons, error) in
            
            if resultData != nil{
                let responsobject = try?JSONSerialization.jsonObject(with: resultData!, options: JSONSerialization.ReadingOptions.allowFragments);
                
                mathFunction(responsobject! as AnyObject);
            }else{
                mathFunction("file" as AnyObject);
            }
        }
        task.resume();
    }
 
    
    //拼接GET参数
    class func parmasStringWithParmas(_ parmas:NSDictionary)->String{
        
        var parString = String();
        let arr = parmas.allKeys as NSArray;
        for i in 0 ..< arr.count{
            let key = arr[i] as! String;
            let value = parmas.object(forKey: arr[i]) as! NSString;
//            parString.appendFormat("%@=%@", key,value);
            parString = parString + key + "=" + (value as String);
            let lastKey = arr.lastObject as! String;
            if (key != lastKey) {
                
//                parString.appendFormat("&");
                parString = parString + "&";
            }

            
        }
        return parString;
    }
    
    //    AFN请求
    //    get请求
    class func AFNGETWithUrl(urlString:String,parmas:NSDictionary,successFunction:@escaping (_ responsObject:AnyObject) -> Void,fileFunction:@escaping (_ responsObject:AnyObject) -> Void){
        
        let manage = AFHTTPSessionManager();
        manage.responseSerializer = AFJSONResponseSerializer();
        manage.requestSerializer = AFJSONRequestSerializer();
     
        manage.get(urlString, parameters: parmas, success: { (opreation, AnyObject) in
            
            successFunction(AnyObject as AnyObject);
            }) { (opreation, error) in
                
              fileFunction(error as AnyObject);
        }
        
       
        
        
    }
    
    //    post请求 formData格式
    class func AFNPOSTWithUrl(urlString:String,parmas:NSDictionary,successFunction:@escaping (_ responsObject:AnyObject) -> Void,fileFunction:@escaping (_ responsObject:AnyObject) -> Void){
        
        let manage = AFHTTPSessionManager();
        manage.responseSerializer = AFJSONResponseSerializer();
        manage.requestSerializer = AFJSONRequestSerializer();
        
        manage.post(urlString as String, parameters: parmas, constructingBodyWith: { (formData) -> Void in
            
            
            
            }, success: { (operation, data1) -> Void in
                
                
                successFunction(data1 as AnyObject);
        }) { (operation, data1) -> Void in
            
            
            fileFunction(data1 as AnyObject);
        }
        
        
    }
    
    
    //    post 普通请求格式
    class func AFNormalNPOSTWithUrl(urlString:String,parmas:NSDictionary,successFunction:@escaping (_ responsObject:AnyObject) -> Void,fileFunction:@escaping (_ responsObject:AnyObject) -> Void){
        
        let manage = AFHTTPSessionManager();
        manage.responseSerializer = AFJSONResponseSerializer();
        manage.requestSerializer = AFJSONRequestSerializer();
        
        manage.post(urlString as String, parameters: parmas, success: { (operation, data1) -> Void in
            
            successFunction(data1 as AnyObject);
        }) { (operation,data1) -> Void in
            
            fileFunction(data1 as AnyObject);
        }
        
    }

}
