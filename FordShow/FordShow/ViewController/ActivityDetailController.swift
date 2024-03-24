//
//  ActivityDetailController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/29.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ActivityDetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //    @IBOutlet weak var switchBtn: UIButton!
    
    
    lazy var btn:UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 480, height: 100))
        btn.setBackgroundImage(UIImage(named: "tab_title"), for: .normal)
        btn.tag = 10
        return btn
    }()
    
    var isVideo: Bool = false {
        didSet{
            //            if self.isVideo {
            //                self.switchBtn.setImage(UIImage(named: "go_pic"), for: .normal)
            //            }else{
            //                self.switchBtn.setImage(UIImage(named: "go_video"), for: .normal)
            //            }
        }
    }
    
    var source:SubjectObjc? {
        didSet{
            self.configData()
        }
    }
    
    
    var dataSource:[(type:String,title:String,img:UIImage,name:String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: "ActivityListPicCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ActivityListPicCollectionCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "projectHeader")
    }
    
    
    func configData() {
        
        if let dsource = self.source {
            if let site = dsource.site {
                self.btn.setTitle("2018一万中征途-\(site)", for: .normal)
                self.btn.center = CGPoint(x: contentWidth/2, y: 50)
            }
            self.btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 36)
            self.dataSource.removeAll()
            if self.isVideo {
                for videoinfo in dsource.videotuples {
                    if let img = getCoverimg(name: videoinfo.1) {
                        self.dataSource.append((type: "video", title: videoinfo.0, img:img , name: videoinfo.1))
                    }
                }
            }else{
                for imginfo in dsource.imgtuples {
                    if let img = UIImage(named: imginfo) {
                        self.dataSource.append((type: "img", title: "", img:img , name: imginfo))
                    }
                }
            }
            
            self.collectionView.reloadData()
        }
        
    }
    
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ActivityDetailController deinit")
    }
    @IBAction func closeAction(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension ActivityDetailController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ActivityListPicCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityListPicCollectionCell", for: indexPath) as! ActivityListPicCollectionCell
        
        if indexPath.row < self.dataSource.count {
            let obj = self.dataSource[indexPath.row]
            
            if self.isVideo {
                cell.titleHeight.constant = 60
                cell.playItem.isHidden = false
                cell.titleLabel.text = obj.title
                cell.pic.image = obj.img
                cell.imageBoxView.isHidden = true
            }else{
                cell.imageBoxView.isHidden = true
                cell.titleHeight.constant = 0
                cell.playItem.isHidden = true
                cell.titleLabel.text = ""
                cell.pic.image = obj.img
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let collectionHeader = "projectHeader"
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionHeader, for: indexPath)
            if head.viewWithTag(10) == nil {
                head.addSubview(self.btn)
            }
            return head
        }
        
        return UICollectionReusableView()
    }
    
}

extension ActivityDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.isVideo {
            let w = contentWidth - 100
            return CGSize(width: w, height: w/2.0)
        }else{
            let w = contentWidth/2 - 50
            return CGSize(width: w, height: w/2.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 进入图片浏览器或者视频播放器
        if indexPath.row < self.dataSource.count {
            let obj = self.dataSource[indexPath.row]
            
            if self.isVideo {
                let vc = FSVideoPlayerVC(frame: UIScreen.main.bounds)
                let name = obj.name
                let filePath = Bundle.main.path(forResource: name, ofType: "mp4")
                vc.url = URL(fileURLWithPath: filePath!)
                guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
                    return
                }
                rootVC.addChild(vc)
                rootVC.view.addSubview(vc.view)
                rootVC.view.bringSubviewToFront(vc.view)
            }else{
                guard let imgs = self.source?.imgtuples else {
                    return
                }
                guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
                    return
                }
                
                let previewVC = ImagePreviewVC(frame: UIScreen.main.bounds,images: imgs, index: indexPath.row)
                rootVC.addChild(previewVC)
                rootVC.view.addSubview(previewVC.view)
                rootVC.view.bringSubviewToFront(previewVC.view)
            }
        }
        
    }
    
}
