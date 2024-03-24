//
//  ViewController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var reptorView: UIView!
    @IBOutlet weak var reptorCoverView: UIView!
    @IBOutlet weak var raptorImgView: UIImageView!
    @IBOutlet weak var mustangCoverView: UIView!
    @IBOutlet weak var mustangView: UIView!
    @IBOutlet weak var mustangImgVIew: UIImageView!
    @IBOutlet weak var rangerCoverView: UIView!
    @IBOutlet weak var rangerView: UIView!
    @IBOutlet weak var rangerImgView: UIImageView!
    @IBOutlet weak var explorerCoverView: UIView!
    @IBOutlet weak var explorerView: UIView!
    @IBOutlet weak var explorerImgVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap0:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgTap0(_:)))
        raptorImgView.addGestureRecognizer(tap0)
        let tap1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgTap1(_:)))
        mustangImgVIew.addGestureRecognizer(tap1)
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgTap2(_:)))
        explorerImgVIew.addGestureRecognizer(tap2)
        let tap3:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgTap3(_:)))
        rangerImgView.addGestureRecognizer(tap3)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        reset()
    }
    
    @objc func imgTap0(_ sender:UITapGestureRecognizer){
        cover(0)
        UIView.animate(withDuration: 0.25, animations: {
            self.coverAlpha(0)
        }, completion: {_ in
            let container = DetailContainerController()
            container.index = 0
            self.navigationController?.pushViewController(container, animated: true)
        })
    }
    
    @objc func imgTap1(_ sender:UITapGestureRecognizer){
        cover(1)
        UIView.animate(withDuration: 0.25, animations: {
            self.coverAlpha(1)
        }, completion: {_ in
            let container = DetailContainerController()
            container.index = 1
            self.navigationController?.pushViewController(container, animated: true)
        })
    }
    
    @objc func imgTap2(_ sender:UITapGestureRecognizer){
        cover(2)
        UIView.animate(withDuration: 0.25, animations: {
            self.coverAlpha(2)
        }, completion: {_ in
            let container = DetailContainerController()
            container.index = 2
            self.navigationController?.pushViewController(container, animated: true)
        })
    }
    
    @objc func imgTap3(_ sender:UITapGestureRecognizer){
        cover(3)
        UIView.animate(withDuration: 0.25, animations: {
            self.coverAlpha(3)
        }, completion: {_ in
            let container = DetailContainerController()
            container.index = 3
            self.navigationController?.pushViewController(container, animated: true)
        })
    }
    
    func cover(_ index: Int) {
        self.reptorCoverView.isHidden = false
        self.reptorCoverView.alpha = 0
        self.mustangCoverView.isHidden = false
        self.mustangCoverView.alpha = 0
        self.rangerCoverView.isHidden = false
        self.rangerCoverView.alpha = 0
        self.explorerCoverView.isHidden = false
        self.explorerCoverView.alpha = 0
        if index == 0 {
            self.reptorCoverView.isHidden = true
        }else if index == 1 {
            self.mustangCoverView.isHidden = true
        }else if index == 2 {
            self.rangerCoverView.isHidden = true
        }else if index == 3 {
            self.explorerCoverView.isHidden = true
        }
    }
    
    func coverAlpha(_ index: Int) {
        self.reptorCoverView.alpha = 1
        self.mustangCoverView.alpha = 1
        self.rangerCoverView.alpha = 1
        self.explorerCoverView.alpha = 1
//        if index == 0 {
//            self.reptorCoverView.alpha = 1
//            self.mustangCoverView.alpha = 1
//            self.rangerCoverView.alpha = 1
//            self.explorerCoverView.alpha = 1
//        }else if index == 1 {
//            self.reptorCoverView.alpha = 1
//            self.mustangCoverView.alpha = 1
//            self.rangerCoverView.alpha = 1
//            self.explorerCoverView.alpha = 1
//        }else if index == 2 {
//            self.reptorCoverView.alpha = 1
//            self.mustangCoverView.alpha = 1
//            self.rangerCoverView.alpha = 1
//            self.explorerCoverView.alpha = 1
//        }else if index == 3 {
//            self.explorerCoverView.isHidden = true
//        }
    }
    
    func reset() {
        self.reptorCoverView.isHidden = true
        self.mustangCoverView.isHidden = true
        self.rangerCoverView.isHidden = true
        self.explorerCoverView.isHidden = true
    }
    
}

