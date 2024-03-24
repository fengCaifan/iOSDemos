//
//  PageViewController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
/// 左右滑动控制器
class PageViewController: UIViewController {
    
    var imageNames:[String] = [] {
        didSet {
            self.pagerControl.numberOfPages = imageNames.count
            self.pagerControl.isHidden = (imageNames.count <= 1)
        }
    }
    
    var index = 0 {
        didSet {
            if index == 0 {
                self.pagerControl.setImage(UIImage(named: "page_white_nor"), for: UIControl.State.normal)
                self.pagerControl.setImage(UIImage(named: "blue_sel"), for: UIControl.State.selected)
            }else if index == 1 {
                self.pagerControl.setImage(UIImage(named: "page_white_nor"), for: UIControl.State.normal)
                self.pagerControl.setImage(UIImage(named: "yellow_sel"), for: UIControl.State.selected)
            }else if index == 2 {
                self.pagerControl.setImage(UIImage(named: "black_sel"), for: UIControl.State.selected)
            }else if index == 3 {
                self.pagerControl.setImage(UIImage(named: "oringe_sel"), for: UIControl.State.selected)
            }
        }
    }

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var pagerControl: FSPageControl! {
        didSet {
            self.pagerControl.setImage(UIImage(named: "page_nor"), for: UIControl.State.normal)
            self.pagerControl.itemSpacing = 36
        }
    }
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            pagerView.transformer = FSPagerViewTransformer(type: .linear)
            pagerView.decelerationDistance = FSPagerView.automaticDistance
            pagerView.dataSource = self
            pagerView.delegate = self
            pagerView.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        backgroundImageView.isHidden = true
    }
    
}

extension PageViewController: FSPagerViewDataSource {
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
}

extension PageViewController: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        pagerControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pagerControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pagerControl.currentPage = pagerView.currentIndex
    }
    
}
