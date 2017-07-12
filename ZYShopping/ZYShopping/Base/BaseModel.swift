//
//  BaseModel.swift
//  BQPReader
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 BQP. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    
    var _map : NSDictionary?;
    
    var map : NSDictionary{
        
        set{
            
            _map = newValue
        }
        
        get{
            
            return _map!
        }
    }
    
    init(dic:Dictionary<String,Any>) {
        super.init()
        
        setAtribute(dic: dic as NSDictionary);
        
    }
    
    func setAtribute(dic:NSDictionary){
        
        if dic.isEqual(NSNull()){
           
            return;
        }
        
        let keyArray = dic.allKeys;
        
        for i in 0..<keyArray.count{
            
            let keys : NSString = keyArray[i] as! NSString;
           
            let firstP = keys.substring(to: 1).uppercased();
            
            let selectedName = NSString (format: "set%@%@:", firstP,keys.substring(from: 1));
            let method :Selector = NSSelectorFromString(selectedName as String);
            
            
            if self.responds(to: method){
                if object_getClass(dic.object(forKey: keys)) == NSNull.classForCoder() {
                    self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                }else{
                 
                    if dic.object(forKey: keys) != nil {
                        self.performSelector(onMainThread: method, with: dic.object(forKey: keys), waitUntilDone: Thread.isMainThread);
                    }else{
                        self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                    }
                }
            }
        }
        if _map == nil{
            return;
        }
//        对特殊字的处理
        let mapArray = _map!.allKeys;
        
        for i in 0 ..< mapArray.count{
            let key : NSString = mapArray[i] as! NSString;
            let selectedName : NSString = (_map?.object(forKey: key))! as! NSString;
            let method :Selector = NSSelectorFromString(selectedName as String);
            if self.responds(to: method){
                
                if object_getClass(dic.object(forKey: key)) == NSNull.classForCoder() {
                    self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                }else{
                    if dic.object(forKey: key) != nil {
                        self.performSelector(onMainThread: method, with: dic.object(forKey: key), waitUntilDone: Thread.isMainThread);
                    }else{
                        self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                    }
                }
            }
        }
    }
}
