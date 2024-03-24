//
//  SubjectController.swift
//  FordShow
//
//  Created by 冯才凡 on 2019/5/8.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

/// 专题活动
class SubjectController: UIViewController {
    
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    var index = 0 {
        didSet {
            emptyImageView.image = UIImage(named: index == 2 ? "empty_txz": "empty_mustang")
            coverImageView.isHidden = false
            if index == 0 {
                coverImageView.image = UIImage(named: "Raptor_act_cover")
            }else if index == 3 {
                coverImageView.image = UIImage(named: "Ranger_act_cover")
            }else{
                coverImageView.isHidden = true
            }
        }
    }
    
    var isVideo = false {
        didSet{
            let img = self.isVideo ? UIImage(named: "go_pic") : UIImage(named: "go_video")
            self.switchButton.setImage(img, for: .normal)
        }
    }
    
    var model: SubjectModel?{
        didSet{
            if let m = model {
                for imgname in m.img {
                    //先添加图片
                    if let img = UIImage(named: imgname) {
                        self.images.append((type: "img", img: img, name:imgname))
                    }
                }
                
                for name in m.video {
                    //video
                    if let img = self.getCoverimg(name: name) {
                        self.images.append((type: "video", img: img, name:name))
                    }
                }
                
            }
            let isEmpty = (model == nil || (model?.img.count == 0) && (model?.video.count == 0))
            emptyImageView.isHidden = !isEmpty
        }
    }
    
    var images:[(type:String,img:UIImage,name:String)] = []
    
    //
    var subobjc:[SubjectObjc]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchButton.isHidden = true
        view.backgroundColor = UIColor.clear
    }
    
    @IBAction func enterActivity(_ sender: Any) {
        if videoController == nil {
            videoController = addSubController(true)
        }
        
        addChild(videoController!)
        view.addSubview(videoController!.view)
        view.bringSubviewToFront(switchButton)
        switchButton.isHidden = false
        self.isVideo = true
    }
    
    /// 初始化活动页实例
    func addSubController(_ isVideo: Bool) -> ActivityViewController {
        let content = ActivityViewController()
        content.isVideo = isVideo
        content.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: UIScreen.main.bounds.height)
        addChild(content)
        view.addSubview(content.view)
        return content
    }
    
    /// 专题图片
    weak var pictureController: ActivityViewController?

    /// 专题视频
    weak var videoController: ActivityViewController?
    
    @IBAction func switchAction(_ sender: Any) {
        let targetRect = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        let originRect = CGRect(x: 0, y: view.frame.height, width: contentWidth, height: view.frame.height)
        let origin1Rect = CGRect(x: 0, y: -view.frame.height, width: contentWidth, height: view.frame.height)
        
        isVideo = !isVideo
        
        if !isVideo {
            if pictureController == nil {
                pictureController = addSubController(false)
            }
            pictureController?.view.frame = originRect
            pictureController?.switchColumn(videoController?.column ?? 0)
        }else{
            if videoController == nil {
                videoController = addSubController(true)
            }
            videoController?.view.frame = origin1Rect
            videoController?.switchColumn(pictureController?.column ?? 0)
        }
        
        self.view.bringSubviewToFront(self.switchButton)
        
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
            if !self.isVideo {
                self.pictureController?.view.frame = targetRect
                self.videoController?.view.frame = origin1Rect
            }else{
                self.videoController?.view.frame = targetRect
                self.pictureController?.view.frame = originRect
            }
        })

    }
    
    /// 获取视频封面图
    func getCoverimg(name:String)->UIImage?{
        if let filePath = Bundle.main.path(forResource: name, ofType: "mp4") {
            let url = URL(fileURLWithPath: filePath)
            let asset:AVAsset = AVAsset(url: url)
            // 生成视频截图
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            let time = CMTimeMakeWithSeconds(Float64(0.0), preferredTimescale: 600)
            var actualTime:CMTime = CMTimeMake(value: Int64(0), timescale: 0)
            
            if let imageRef:CGImage = try? generator.copyCGImage(at: time, actualTime: &actualTime) {
                return UIImage(cgImage: imageRef)
            }
        }
        return nil
    }

    func popController() {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            if self.pictureController?.parent != nil {
                self.pictureController?.view.alpha = 0
            }
            if self.videoController?.parent != nil {
                self.videoController?.view.alpha = 0
            }
            
        }, completion: {_ in
            if self.pictureController?.parent != nil {
                self.pictureController?.view.removeFromSuperview()
                self.pictureController?.removeFromParent()
            }
            if self.videoController?.parent != nil {
                self.videoController?.view.removeFromSuperview()
                self.videoController?.removeFromParent()
            }
        })
        
        switchButton.isHidden = true
    }
    
    deinit {
        print("SubjectController deinit")
    }

}
