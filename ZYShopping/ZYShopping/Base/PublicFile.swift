//
//  PublicFile.swift
//  ZYShopping
//
//  Created by ybon on 2017/5/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import Foundation
let BaseUrl = "http://192.168.1.113:8888";
//let BaseUrl = "http://0.0.0.0:8888";
let kScreenWidth = UIScreen.main.bounds.size.width;
let kScreenHeight = UIScreen.main.bounds.size.height;
let kScreen = UIScreen.main.bounds;
//获取缓存文件大小
func getCachesSize()-> String{
    let intg = SDImageCache.shared().getSize();
    let size11 = intg/1000/1000;
    let sizeStr = "\(size11)M";
    return sizeStr;
}
//清楚缓存
func clearDisk(){
    SDImageCache.shared().clearDisk();
}
