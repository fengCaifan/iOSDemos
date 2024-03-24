//
//  DetailVideoController.swift
//  FordShow
//
//  Created by 冯才凡 on 2019/5/8.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

//视频
class DetailVideoController: UIViewController {
    
//    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg"]
    var videoNames:[String]!{
        didSet{
            for name in videoNames {
                if let img = self.getCoverimg(name: name) {
                    self.images.append(img)
                    self.imgVideo.append((name: name, img: img))
                }
            }
            self.fsPageView.reloadData()
        }
    }
    var images:[UIImage] = []
    
    var imgVideo:[(name:String,img:UIImage)] = []

    @IBOutlet weak var leftLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var fsPageView: FSPagerView!{
        didSet {
            fsPageView.register(FSPageVideoViewCell.self, forCellWithReuseIdentifier: "videocell")
            fsPageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2)
            
            fsPageView.transformer = FSPagerViewTransformer(type: .overlap)
            
            fsPageView.decelerationDistance = FSPagerView.automaticDistance
            fsPageView.dataSource = self
            fsPageView.delegate = self
            fsPageView.bounces = false
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leftLayoutConstraint.constant = contentWidth * 0.08
        let transform = CGAffineTransform(scaleX: 0.47, y: 0.75)
        fsPageView.itemSize = self.fsPageView.frame.size.applying(transform)
        
        fsPageView.reloadData()
        view.backgroundColor = UIColor.clear
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //获取视频封面图
    func getCoverimg(name:String)->UIImage?{
        if let filePath = Bundle.main.path(forResource: name, ofType: "mp4") {
            let url = URL(fileURLWithPath: filePath)
            let asset:AVAsset = AVAsset(url: url)
            //生成视频截图
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

}

extension DetailVideoController: FSPagerViewDataSource {
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:FSPageVideoViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "videocell", at: index) as! FSPageVideoViewCell
        cell.imageView?.image = self.images[index] //UIImage(named: )
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi/2)
        cell.iconImgView.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi/2)
        return cell
    }
}

extension DetailVideoController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        
//        if let parentVC:DetailContainerController = self.parent as? DetailContainerController {
//            let vc = FSVideoPlayerVC(frame: UIScreen.main.bounds)
//            let name = self.imgVideo[index].name
//            let filePath = Bundle.main.path(forResource: name, ofType: "mp4")
//            vc.url = URL(fileURLWithPath: filePath!)
//            parentVC.addChild(vc)
//            parentVC.view.addSubview(vc.view)
//        }
        
        let vc = FSVideoPlayerVC(frame: UIScreen.main.bounds)
        let name = self.imgVideo[index].name
        let filePath = Bundle.main.path(forResource: name, ofType: "mp4")
        vc.url = URL(fileURLWithPath: filePath!)
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        rootVC.addChild(vc)
        rootVC.view.addSubview(vc.view)
        rootVC.view.bringSubviewToFront(vc.view)
        
    }
}
