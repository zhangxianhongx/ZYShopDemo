//
//  ZYVideoTableViewCell.swift
//  搞笑视频
//
//  Created by ybon on 2017/2/23.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit
import AVFoundation
class ZYVideoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descImgV: UIImageView!
    
    @IBOutlet weak var srcImgV: UIImageView!
    
    @IBOutlet weak var srcLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    private var _dataDic:Dictionary<String,Any>?;
    private var _player:AVPlayer?;
    private var _layer:AVPlayerLayer?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setDataDic(dataDic:Dictionary<String,Any>){
        
        if _player != nil {
            self.pasuh();
        }
        
        _dataDic = dataDic;
        titleLabel.text = _dataDic?["text"] as? String;
        descImgV.sd_setImage(with: URL.init(string: (_dataDic?["video_img"] as? String)!));
        srcImgV.sd_setImage(with: URL.init(string: (_dataDic?["profile_image"] as? String)!));
        srcLabel.text = _dataDic?["name"] as? String;
        timeLabel.text = _dataDic?["create_time"] as? String;
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        
        
    }
    
    //播放
    func player(){
        if _player?.timeControlStatus == AVPlayerTimeControlStatus.playing {
            
            _player?.pause();
            return;
        }else if  _player?.timeControlStatus == AVPlayerTimeControlStatus.paused{
            _player?.play();
            return;
        }
        _player = AVPlayer.init(url: URL.init(string: (_dataDic?["video_url"] as? String)!)!);
        _layer = AVPlayerLayer.init(player: _player);
        _layer?.frame = descImgV.frame;
        self.layer.addSublayer(_layer!);
        _player?.play();
        descImgV.isHidden = true;
    }
    //暂停
    func pasuh(){
        if _player == nil {
            return;
        }
        _player?.pause();
        _player = nil;
        _layer?.removeFromSuperlayer();
        _layer = nil;
        descImgV.isHidden = false;
    }
}
