//
//  CoreWork.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit
let BaseUrlBmob = "http://cloud.bmob.cn/7c562cf1d3838d41/";
class CoreWork: NSObject {

    /**
     登录接口
     */
    class func login(phone:String,password:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@userLogin",BaseUrlBmob);
        let parmas = ["name":phone,"password":password];
        RequestWork.AFNormalNPOSTWithUrl(urlString: url, parmas: parmas as NSDictionary, successFunction: { (object) in
            
            resultFunction(object);
        }) { (object) in
            resultFunction(object);
            
        }
        
        
    }
    /**
     注册接口
     */
    class func regist(name:String,phone:String,password:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@userRegist",BaseUrlBmob);
        let parmas = ["name":name,"phone":phone,"password":password];
        RequestWork.AFNormalNPOSTWithUrl(urlString: url, parmas: parmas as NSDictionary, successFunction: { (object) in
            
                resultFunction(object);
            }) { (object) in
                resultFunction(object);
                
        }
        
    }
    /**
     获取个人信息 
     */
    class func getPersonInfo(userID:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@getOneUser",BaseUrlBmob);
        let parmas = ["id":userID];
       
        RequestWork.AFNGETWithUrl(urlString: url, parmas: parmas as NSDictionary, successFunction: { (object) in
            
            resultFunction(object);
            }) { (object) in
             resultFunction(object);
                
        }
        
        
    }
    /**
     更新个人信息
     */
    class func upUserInfomation(dic:Dictionary<String,Any>,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@updateUserInfoMation",BaseUrlBmob);
        RequestWork.AFNormalNPOSTWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (object) in
            
            resultFunction(object);
        }) { (object) in
            resultFunction(object);
            
        }

        
    }
    /**
     上传图片
     */

    class func upImage(dic:Dictionary<String,UIImage>,resultFunction:@escaping (_ responsObject:Any) -> Void){
        
        let image1 = dic["image"];
        let image = CommentConfig.imageCompress(forWidth: image1, targetWidth: kScreenWidth);
        let obj = BmobObject(className: "UserImageList");
        let data = UIImageJPEGRepresentation(image! , 0.5);
        //        let dataString = reDate()
        let imageName = reDate() + ".jpg";
        let file = BmobFile.init(fileName: imageName as String, withFileData: data);
        
        file?.saveInBackground { [weak file] (isSuccessful, error) in
            if isSuccessful {
                //如果文件保存成功，则把文件添加到file列
                let weakFile = file
                print("ddddd",file?.url);
                let resultDic = ["code":"200","imgUrl":(file?.url)! as String];
                resultFunction(resultDic);

                obj?.setObject(weakFile, forKey: "image")
                obj?.setObject(UserDefaults.standard.object(forKey: "ID"), forKey: "pub_id")
                obj?.saveInBackground(resultBlock: { (success, err) in
                    if err != nil {
                        print("save \(error)")
                    }
                    print("ssssss",file?.url);
                
                })
            }else{
                let resultDic = ["code":"201"];
                resultFunction(resultDic);
                print("upload \(error)")
            }
            
        }

    
    
    }
   
    /**
     提交意见反馈
     */
    class func upIdeaFeedBack(message:String,send_id:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@addIdeaBack",BaseUrlBmob);
        let dic = ["message":message,"send_id":send_id];
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
                resultFunction(anyObject);
            }) { (anyObject) in
                
               resultFunction(anyObject);
        }
    }
    /**
      获取所有联系人
     */
    class func getAllFriend(pageSize:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        
        let url = String.init(format: "%@getAllUser",BaseUrlBmob);
        let dic = ["pagesize":pageSize];
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            resultFunction(anyObject);
        }) { (anyObject) in
            
            resultFunction(anyObject);
        }
    }
    
    /**
     获取视频数据
     */
    class func homeHeaderList(page:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        
        let url = "http://route.showapi.com/1269-1";
        let dateString = reDate();
        let dic = ["showapi_appid":"12308","showapi_sign":"baafffe1aa384a2aa4cef4d0705f6350","showapi_timestamp":dateString,"page":page] as NSDictionary;
        
       RequestWork.zyGETWithURLSession(url, parmas: dic) { (anobject) in
        
            Block(anobject);
        }
        
    }
    /**
     获取轮播图数据
     */
    class func gethomeHeaderList(Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "getHomeImgList";
        
        let dic = [:] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }
    }
    /**
     获取首页数据
     */
    class func gethomeList(pageSize:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "getHomeShopList";
        
        let dic = ["pagesize":pageSize] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }

    }
    /**
     获取商品详情图片
     */
    class func getShopImagList(shopid:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "getShopImgList";
        
        let dic = ["shop_id":shopid] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }
        
    }
    /**
     查询已发布商品
     */
    class func getHistoryShop(userid:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "getMyShopList";
        
        let dic = ["id":userid] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }
        
    }
    /**
     删除商品
     */
    class func deleteHistoryShop(shop_id:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "deleteMyShop";
        
        let dic = ["shop_id":shop_id] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }
        
    }
    /**
     发布商品
     */
    class func pubShop(shopinfo:Dictionary<String,Any>,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrl + "/zymeb/addshop";
        
        let dic = shopinfo as NSDictionary;
        
        RequestWork.zyGETWithURLSession(url, parmas: dic) { (anobject) in
            
            Block(anobject);
        }
        
    }
    /**
     获取商品评论
     */
    class func getShopComentList(shop_id:String,pagesize:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "getShopCommentList";
        
        let dic = ["shop_id":shop_id,"pagesize":pagesize];
        
        RequestWork.zyGETWithURLSession(url, parmas: dic as NSDictionary) { (anobject) in
            
            Block(anobject);
        }
        
    }
    /**
     添加商品评论
     */
    class func addShopComent(dic:Dictionary<String,String>,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "addShopComent";
        
        RequestWork.zyGETWithURLSession(url, parmas: dic as NSDictionary) { (anobject) in
            
            Block(anobject);
        }
        
    }
    /**
     修改手机号
     */
    class func changePhoneNum(phoneNum:String,pwd:String,newphone:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@/zymeb/changePhoneNum",BaseUrl);
        let dic = ["phoneNum":phoneNum,"password":pwd,"newphone":newphone];
        RequestWork.zyPOSTwithURLSession(url, parmas: dic as NSDictionary) { (anyobject) in
            
            resultFunction(anyobject);
        }
    }
    
    /**
     修改密码
     */
    class func changePWD(phoneNum:String,pwd:String,newpwd:String,resultFunction:@escaping (_ responsObject:Any) -> Void){
        let url = String.init(format: "%@/zymeb/changePWD",BaseUrl);
        let dic = ["phoneNum":phoneNum,"password":pwd,"newpwd":newpwd];
        RequestWork.zyPOSTwithURLSession(url, parmas: dic as NSDictionary) { (anyobject) in
            
            resultFunction(anyobject);
        }
    }
    /**
     举报用户
     */
    class func reportUser(r_id:String,rd_id:String,message:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "userReport";
        
        let dic = ["r_id":r_id,"rd_id":rd_id,"message":message] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }
        
    }

    /**
     获取首页数据
     */
    class func getActivList(pageSize:String,Block:@escaping (_ responsObject:AnyObject) -> Void){
        let url = BaseUrlBmob + "getWeChatActiveList";
        
        let dic = ["pagesize":pageSize] as NSDictionary;
        
        RequestWork.AFNGETWithUrl(urlString: url, parmas: dic as NSDictionary, successFunction: { (anyObject) in
            
            Block(anyObject);
        }) { (anyObject) in
            
            Block(anyObject);
        }
        
    }
    //返回指定格式的时间
    //    + (NSString *)returnDate{
    class func reDate()-> String{
        //    yyyyMMddHHmmss
        let date = Date();
        //NSTimeZone *zone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        //    let zone = NSTimeZone(name: "Asia/Shanghai");
        let zone = TimeZone.init(identifier: "Asia/Shanghai");
        let formatter = DateFormatter();
        formatter.timeZone = zone ;
        formatter.dateFormat = "yyyyMMddHHmmss";
        
        let dateString = formatter.string(from: date);
        
        return dateString;
        
    }

}
