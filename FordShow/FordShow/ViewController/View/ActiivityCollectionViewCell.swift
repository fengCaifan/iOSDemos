//
//  ActiivityCollectionViewCell.swift
//  FordShow
//
//  Created by xinyue on 2019/5/29.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

enum ColumnStyle {
    case single
    case double
}

class ActiivityCollectionViewCell: UICollectionViewCell {
    
    private var itemDidSelected: ((SubjectObjc?) -> Void)? = nil
    
    private var style = ColumnStyle.single
    
    var isVideo:Bool = false
    
    var type:SubjectType = .new
    
    private var model: SubjectInfo? {
        didSet {
            self.configData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource:[(type:String,title:String,img:UIImage,name:String)] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "ActivityListPicCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ActivityListPicCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.reloadData()
    }
    
    func set(_ model: SubjectInfo?, style: ColumnStyle = .single, isVideo: Bool = false, didSelectItem: ((SubjectObjc?) -> Void)? = nil) {
        itemDidSelected = didSelectItem
        self.isVideo = isVideo
        self.model = model
        self.style = style
        
    }
    
    
    func configData() {
        
        self.dataSource.removeAll()
        if let subjects0 = self.model?.subjects {
            for subject1 in subjects0 {
                
                if subject1.type == .new {
                    self.type = .new
                    if self.style == .single {
                        //视频
                        for videoinfo in subject1.videotuples {
                            if let img = getCoverimg(name: videoinfo.1) {
                                self.dataSource.append((type: "video", title: videoinfo.0, img:img , name: videoinfo.1))
                            }
                        }
                    }else{
                        //
                        for imginfo in subject1.imgtuples {
                            if let img = UIImage(named: imginfo) {
                                self.dataSource.append((type: "img", title: "", img:img , name: imginfo))
                            }
                        }
                    }
                }else{
                    //往期
                    self.type = .past
                    if self.isVideo {
                        //视频
                        if let videoinfo = subject1.videotuples.first, let imgname = subject1.videoCover, let img = UIImage(named: imgname) {//let img = getCoverimg(name: videoinfo.1)
                            self.dataSource.append((type: "video", title: subject1.site ?? "", img:img , name: videoinfo.1))
                        }
                    }else{
                        //
                        if let imginfo = subject1.imgtuples.first,let imgname = subject1.imgsCover, let img = UIImage(named: imgname)  {
                            self.dataSource.append((type: "img", title: subject1.site ?? "", img:img , name: imginfo))
                        }
                    }
                }
            }
        }
        
        self.collectionView.reloadData()
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
    
}

extension ActiivityCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
                
                if self.type == .past {
                    cell.playItem.isHidden = true
                }
                
            }else{
                cell.titleHeight.constant = 0
                cell.playItem.isHidden = true
                cell.titleLabel.text = ""
                cell.pic.image = obj.img
                
                if self.type == .past {
                    cell.titleHeight.constant = 60
                     cell.titleLabel.text = "2018一万中征途-\(obj.title)"
                    cell.imageBoxView.isHidden = false
                }else{
                    cell.imageBoxView.isHidden = true
                }
                
            }
        }
        
        return cell
    }
}

extension ActiivityCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.style == .single {
            let w = contentWidth - 100
            return CGSize(width: w, height: w/2.0)
        }else{
            let w = contentWidth/2 - 50
            return CGSize(width: w, height: w/2.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.type == .past {
            if let subjects = self.model?.subjects {
                if indexPath.row < subjects.count {
                    self.itemDidSelected?(subjects[indexPath.row])
                }
            }
        }else{
            
            guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
                return
            }
            if self.style == .single {
                //视频
                if indexPath.row < self.dataSource.count {
                    let obj = self.dataSource[indexPath.row]
                    let vc = FSVideoPlayerVC(frame: UIScreen.main.bounds)
                    let name = obj.name
                    let filePath = Bundle.main.path(forResource: name, ofType: "mp4")
                    vc.url = URL(fileURLWithPath: filePath!)
                    rootVC.addChild(vc)
                    rootVC.view.addSubview(vc.view)
                    rootVC.view.bringSubviewToFront(vc.view)
                }
            }else{
                //图片
                if let obj:SubjectObjc = self.model?.subjects.first {
                    let previewVC = ImagePreviewVC(frame: UIScreen.main.bounds,images: obj.imgtuples , index: indexPath.row)
                    rootVC.addChild(previewVC)
                    rootVC.view.addSubview(previewVC.view)
                    rootVC.view.bringSubviewToFront(previewVC.view)
                }
            }
        }
    }
    
    
    //获取任意试图view所属视图控制器UIViewController
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let response = view?.next {
                if response.isKind(of: UIViewController.self){
                    return response as? UIViewController
                }
            }
        }
        return nil
    }
}

