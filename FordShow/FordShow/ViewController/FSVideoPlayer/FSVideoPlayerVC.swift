//
//  FSVideoPlayerVC.swift
//  FordShow
//
//  Created by 冯才凡 on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

//手势方向
enum Direction {
    case leftOrRight
    case upOrDown
    case none
}

class FSVideoPlayerVC: UIViewController {
    
    var url:URL? = nil {
        didSet {
            updateUI()
        }
    }
    var playerView:UIView!
    
    var avplayer:AVPlayer!
    var playerItem:AVPlayerItem?
    var playerLayer:AVPlayerLayer?
    
    var playing:Bool = false //是否正在播放
    var link:CADisplayLink! //定时器
    var sliding = false //滑块是否在滑动
    
    //手势相关
    lazy var touchLayer:VideoTopTouchLayer = {
        let layer:VideoTopTouchLayer = VideoTopTouchLayer(frame: CGRect(x: 0, y: 0, width: self.playerView.frame.size.width, height: self.playerView.frame.size.height - self.bottomView.frame.size.height))
        layer.touchDelegate = self
        return layer
    }()
    var startPoint:CGPoint! //手势开始触摸的点
    var startVB:Float = 0 //开始的音量
    var direction:Direction = .none //手势滑动方向

//    var totalTime:TimeInterval = 0 //总时长
//    var startVideoRate:CGFloat = 0.0 //手势触摸时，视频的播放进度
//    var currentRate:CGFloat = 0.0 //当前播放进度
    var volumeViewSlider:UISlider?
    
    lazy var volumeView:MPVolumeView = {
        let volumeview:MPVolumeView = MPVolumeView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (self.view.frame.size.width*9.0/16.0)))
        volumeview.sizeToFit()
        for view in volumeview.subviews {
            if NSStringFromClass(view.classForCoder) == "MPVolumeSlider" {
                self.volumeViewSlider = (view as! UISlider)
            }
        }
        return volumeview
    }()
    
    
    lazy var bottomView:UIView = {
        let v = UIView(frame: CGRect(x: 0, y: self.playerView.frame.height-44, width: self.playerView.frame.width, height: 30))
        v.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return v
    }()
    
    //右上角退出按钮
    lazy var closeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: self.playerView.frame.width - 80, y: 0, width: 44, height: 44)
        btn.setImage(UIImage(named: "closew"), for: .normal)
        btn.alpha = 0.7
        btn.backgroundColor = UIColor.lightGray
        btn.layer.cornerRadius = 22
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //播放按钮
    lazy var playBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 30, y: 4, width: 36, height: 36)
        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.layer.cornerRadius = 22
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(playBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //滑块
    lazy var slide:UISlider = {
        let w:CGFloat = self.playerView.frame.width - 244 //30.0 - 44.0 - 30 - 30 - 80 - 30
        let slider:UISlider = UISlider(frame:CGRect(x:(30 + 30 + 44), y:0, width:w, height:44))
        slider.center = self.view.center
        slider.minimumValue = 0  //最小值
        slider.maximumValue = 1  //最大值
        slider.value = 0.0  //当前默认值
        slider.minimumTrackTintColor = UIColor.gray //左边槽的颜色
        slider.maximumTrackTintColor = UIColor.lightGray //右边槽的颜色
        
        //按下
        slider.addTarget(self, action: #selector(sliderTouchDown(_:)), for: .touchDown)
        //抬起
        slider.addTarget(self, action: #selector(sliderTouchUpOut(_:)), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(_:)), for: .touchCancel)
        
        return slider
    }()
    
    //缓冲进度条 暂时不加
    lazy var progress:UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.center = self.slide.center
        progressView.progress = 0 //默认进度50%
        progressView.progressTintColor = UIColor.red   //已有进度颜色
        progressView.trackTintColor = UIColor.green  //剩余进度颜色（即进度槽颜色）
        return progressView
    }()
    
    //时间
    lazy var timeLabel:UILabel = {
        let l = UILabel(frame: CGRect(x: self.playerView.frame.width - 100 - 30, y: 0, width: 100, height: 44))
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        l.textColor = UIColor.gray
        return l
    }()
    
    //毛玻璃
    lazy var ev:UIVisualEffectView = {
        let ef:UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let ev:UIVisualEffectView = UIVisualEffectView(effect: ef)
        ev.frame = self.view.bounds
        return ev
    }()
    
    //初始化
    init(frame:CGRect){
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.ev.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        let playerViewH = getHeight()
        

        self.playerView.frame = CGRect(x: 0, y: (self.view.frame.size.height-playerViewH)/2.0, width: self.view.frame.size.width, height:  playerViewH)
        self.playerLayer?.frame = self.playerView.bounds
        self.closeBtn.frame =  CGRect(x: self.playerView.frame.width - 80, y: 10, width: 60, height: 44)
        self.bottomView.frame = CGRect(x: 0, y: playerViewH-44, width: self.playerView.frame.width, height: 44)
        
        self.playBtn.frame = CGRect(x: 30, y: 0, width: 44, height: 44)
        self.timeLabel.frame = CGRect(x: self.playerView.frame.width - 100 - 30, y: 0, width: 100, height: 44)
        
        let w:CGFloat = self.playerView.frame.width - 264 //30.0 - 44.0 - 30 - 30 - 100 - 30
        self.slide.frame = CGRect(x:(30 + 30 + 44), y:0, width:w, height:44)
        self.progress.center = self.slide.center
        
        self.volumeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (self.view.frame.size.width*9.0/16.0))
        self.touchLayer.frame = CGRect(x: 0, y: 0, width: self.playerView.frame.size.width, height: self.playerView.frame.size.height - self.bottomView.frame.size.height)
    }
    
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(self.ev)
        
        
        self.playerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-160))
        view.addSubview(self.playerView)
        self.playerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.playerView.addSubview(self.closeBtn)
        
        self.playerView.addSubview(self.bottomView)
        self.playerView.bringSubviewToFront(self.bottomView)
        
        self.bottomView.addSubview(self.playBtn)
        self.bottomView.addSubview(self.slide)
        self.bottomView.addSubview(self.timeLabel)
        
    }
    
    func updateUI(){
        if let videoURL = self.url {
            
            self.playerItem = AVPlayerItem(url: videoURL)
            self.avplayer = AVPlayer(playerItem: self.playerItem)
            self.playerLayer = AVPlayerLayer(player: self.avplayer)
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
            playerLayer?.contentsScale = UIScreen.main.scale
            // 赋值给自定义的View
            self.playerLayer?.frame = self.playerView.bounds
            // 位置放在最底下
            self.playerView.layer.insertSublayer(playerLayer!, at: 0)
            
            //监听缓冲进度改变
            playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
            //监听状态改变
            playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)

            
            self.avplayer.play()
            
            self.link = CADisplayLink(target: self, selector: #selector(updateTime))
            self.link.add( to: RunLoop.main, forMode: RunLoop.Mode.default)
            
            self.playerView.addSubview(self.touchLayer)
            
            self.playerView.bringSubviewToFront(self.closeBtn)
        }
    }
    
    @objc func updateTime(){
        if !self.playing {
            return
        }
        if self.avplayer != nil && self.playerItem != nil {
            let currentTime = CMTimeGetSeconds(self.avplayer.currentTime())
            //总时长
            let totalTime = TimeInterval(self.playerItem?.duration.value ?? 0)/TimeInterval(self.playerItem?.duration.timescale ?? 0)
            let timeStr = "\(formatPlayTime(secounds: currentTime))/\(formatPlayTime(secounds: totalTime))"
            self.timeLabel.text = timeStr // 赋值
            if !self.sliding {
                self.slide.value = Float(currentTime/totalTime)
            }
        }
    }
    
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem?.removeObserver(self, forKeyPath: "status")
        print("==========")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        avplayer.pause()
    }
    
    @objc func closeBtnAction(){
        self.avplayer.pause()
        link.invalidate()
        link = nil
        self.view.removeFromSuperview()
        self.removeFromParent()  
    }
    
    @objc func playBtnAction(){
        if !playing {
            //不在播放，点击后进行播放
            self.playBtn.setImage(UIImage(named: "pause"), for: .normal)
            self.avplayer.play()
            self.playing = true
        }else{
            self.playBtn.setImage(UIImage(named: "play"), for: .normal)
            self.avplayer.pause()
            self.playing = false
        }
        
    }
    
    @objc func sliderTouchDown(_ slider:UISlider) {
        if self.avplayer != nil && self.playerItem != nil {
            self.sliding = true
        }
    }
    
    @objc func sliderTouchUpOut(_ slider:UISlider) {
        if self.avplayer != nil && self.playerItem != nil {
            if self.avplayer.status == .readyToPlay {
                let duration = slider.value*Float(CMTimeGetSeconds(self.avplayer.currentItem!.duration))
                let seekTime = CMTimeMake(value: Int64(duration), timescale: 1)
                self.avplayer.seek(to: seekTime) {[weak self] (b) in
                    guard let `self` = self else {return}
                    self.sliding = false
                }
            }
        }
    }
    
    //视频播放完毕响应
    @objc func playerDidFinishPlaying() {
        print("播放完毕!")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        if keyPath == "loadedTimeRanges"{
            // 缓冲进度 暂时不处理
        }else if keyPath == "status"{
            // 监听状态改变
            if playerItem.status == AVPlayerItem.Status.readyToPlay{
                // 只有在这个状态下才能播放
                self.avplayer.play()
                self.playing = true
                self.playBtn.setImage(UIImage(named: "pause"), for: .normal)
            }else{
                print("加载异常")
            }
        }
    }

}

extension FSVideoPlayerVC {
    func formatPlayTime(secounds:TimeInterval)->String{
        if secounds.isNaN{
            return "00:00"
        }
        let Min = Int(secounds / 60.0)
        let Sec = Int(secounds) % 60
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    //获取视频尺寸
    func getHeight()->CGFloat {
        var H:CGFloat = self.view.frame.height
        if let url = self.url {
            let asset:AVAsset = AVAsset(url: url)
            let tracks = asset.tracks(withMediaType: AVMediaType.video)
            if tracks.count > 0 {
                if let vtrack = tracks.first {
                    print("w:\(vtrack.naturalSize.width),h:\(vtrack.naturalSize.height)")
                    
                    let h1  = (self.view.frame.width*vtrack.naturalSize.height*1.0)/vtrack.naturalSize.width
                    
                    if H > h1 {
                        H = h1
                    }
                    
                }
            }
        }
        return H
    }
}


extension FSVideoPlayerVC:VideoTopTouchLayerDelegate{
    func touchesBeganWithPoint(point:CGPoint?) {
        if let p = point, playing == true {
            self.startPoint = p
            self.startVB = self.volumeViewSlider?.value ?? 0.0
            self.direction = .none
            
            //记录视频当前播放进度
//            let ctime:CMTime = self.avplayer.currentTime()
//            let t = CGFloat(ctime.value)/CGFloat(ctime.timescale)
//            self.startVideoRate = t/CGFloat(self.totalTime)
        }
    }
    
    func touchesEndedWithPoint(point:CGPoint?) {
//        let seekTime = CMTimeMake(value: Int64(duration), timescale: 1)
//        self.avplayer.seek(to: seekTime) {[weak self] (b) in
//            guard let `self` = self else {return}
//            self.sliding = false
//        }
    }
    
    func touchesMovedWithPoint(point:CGPoint?) {
        if let p = point, self.startPoint != nil  {
            let panPoint = CGPoint(x: (p.x - self.startPoint.x), y: (p.y - self.startPoint.y))
            if self.direction == .none {
                if panPoint.x >= 30 || panPoint.x <= -30 {
                    self.direction = .leftOrRight //横向
                }else if panPoint.y >= 30 || panPoint.y <= -30 {
                    self.direction = .upOrDown //纵向
                }
            }
            if self.direction == .none {
                return
            }else if self.direction == .upOrDown {
                //调节音量
                if let slider0 = self.volumeViewSlider {
                    if panPoint.y < 0 {
                        //增加音量
                        let v:Float = self.startVB + Float((-panPoint.y / 30.0 / 10))
                        slider0.setValue(v, animated: true)
                        if v - slider0.value >= 0.1 {
                            slider0.setValue(0.1, animated: true)
                            slider0.setValue(v, animated: true)
                        }
                    }else{
                        //减小音量
                        let v:Float = self.startVB - Float((panPoint.y / 30.0 / 10))
                        slider0.setValue(v, animated: true)
                    }
                    
                    print("volume:\(slider0.value)")
                }
                
            }else if self.direction == .leftOrRight{
                //进度 TODO
            }
        }
    }
}
