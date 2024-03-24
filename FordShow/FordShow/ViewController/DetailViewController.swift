//
//  DetailViewController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

//图片
class DetailViewController: UIViewController {

    
//    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg"]
    var imageNames:[String] = []
    
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftConstraint.constant = contentWidth * 0.08
        let transform = CGAffineTransform(scaleX: 0.47, y: 0.75)
        pagerView.itemSize = self.pagerView.frame.size.applying(transform)
        
        pagerView.reloadData()
        view.backgroundColor = UIColor.clear
    }
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            pagerView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2)
            
            pagerView.transformer = FSPagerViewTransformer(type: .overlap)
            
            pagerView.decelerationDistance = FSPagerView.automaticDistance
            pagerView.dataSource = self
            pagerView.delegate = self
            pagerView.bounces = false
        }
    }

}

extension DetailViewController: FSPagerViewDataSource {
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi/2)
        return cell
    }
}

extension DetailViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        
        if let parentVC:DetailContainerController = self.parent as? DetailContainerController {
            let previewVC = ImagePreviewVC(frame:CGRect(x: 0, y: 0, width: parentVC.view.frame.width, height: parentVC.view.frame.height),images: [self.imageNames[index]], index: index)
            parentVC.addChild(previewVC)
            parentVC.view.addSubview(previewVC.view)
        }
        
    }
}
