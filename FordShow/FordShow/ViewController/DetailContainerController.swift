//
//  DetailContainerController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
/// 二级页面最外层容器
class DetailContainerController: UIViewController {
    
    var index = 0
    
    private var vc: UIViewController?
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            if index == 0 {
                 backgroundImageView.image = UIImage(named: "mengqin_bg")
            }else if index == 1 {
                backgroundImageView.image = UIImage(named: "mustang_bg")
                backgroundImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            }else if index == 2 {
                backgroundImageView.image = UIImage(named: "tangxianzhe_bg")
            }else if index == 3 {
                backgroundImageView.image = UIImage(named: "ranger_bg")
                backgroundImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            }
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    lazy var menuController: DetailMenuController = {
        let menu = DetailMenuController()
        menu.view.frame = CGRect(x: view.frame.width-menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        return menu
    }()
    
    //外观
    lazy var contentController: DetailViewController = {
        let content = DetailViewController()
        content.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        return content
    }()
    
    // 首页
    lazy var homeController: HomeViewController = {
        let home = HomeViewController()
        home.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        return home
    }()
    
    //专题视频
    lazy var videoContentVC:DetailVideoController = {
        let content = DetailVideoController()
        content.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        return content
    }()
    
    //参数
    lazy var dataController: DataViewController = {
        let content = DataViewController()
        content.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        return content
    }()
    
    //官方指导价
    lazy var defaultController: PageViewController = {
        let content = PageViewController()
        content.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        return content
    }()
    
    //专题
    lazy var subjectController:SubjectController = {
        let content = SubjectController()
        content.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        return content
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addChild(menuController)
        self.view.addSubview(menuController.view)
        
        homeController.index = self.index
        self.addChild(homeController)
        self.view.addSubview(homeController.view)
        self.vc = homeController
        
        self.view.bringSubviewToFront(self.contentController.view)
        
        self.view.bringSubviewToFront(self.backButton)
        
        
        self.reloadData()
        
        menuController.menuBtnAction = {[weak self] (index) in
            guard let `self` = self else {return}
            
            self.vc?.view.removeFromSuperview()
            self.vc?.removeFromParent()
            
            switch index {
            case 0:
                self.addChild(self.contentController)
                self.view.addSubview(self.contentController.view)
                self.vc = self.contentController
                break
            case 1:
                self.addChild(self.videoContentVC)
                self.view.addSubview(self.videoContentVC.view)
                self.vc = self.videoContentVC
                break
            case 2:
                self.addChild(self.dataController)
                self.view.addSubview(self.dataController.view)
                self.vc = self.dataController
                break
            case 3:
                self.addChild(self.defaultController)
                self.view.addSubview(self.defaultController.view)
                self.defaultController.index = self.index
                self.vc = self.defaultController
                
                break
            case 4:
                self.addChild(self.subjectController)
                self.view.addSubview(self.subjectController.view)
                self.subjectController.index = self.index
                self.vc = self.subjectController
                break
            default:
                break
            }
            self.view.bringSubviewToFront(self.backButton)
        }
        
        
        
    }
    
    
    func reloadData() {
        let carModel:CarModel = DataSource[index]
        
        if let pics = carModel.pics.first?.items, pics.count > 0 {
            contentController.imageNames = pics
        }
        
        if let videos = carModel.video.first?.items, videos.count > 0 {
            videoContentVC.videoNames = videos
        }
        
        let dataSource = carModel.data
        dataController.dataSource = dataSource
        
        
        if let price = carModel.price.first?.items, price.count > 0 {
            defaultController.imageNames = price
        }
        
        if carModel.subjectObjcs.count > 0 {
            subjectController.subobjc = carModel.subjectObjcs
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        homeController.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        
        menuController.view.frame = CGRect(x: contentWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        contentController.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        
        videoContentVC.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        
        dataController.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        
        defaultController.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
        
        subjectController.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: view.frame.height)
    }
    
    @IBAction func popController(_ sender: Any) {
        if self.vc == subjectController, self.vc?.children.count != 0 {
            subjectController.popController()
        }else if self.vc != homeController {
            self.vc?.removeFromParent()
            self.vc?.view.removeFromSuperview()
            
            homeController.index = self.index
            self.addChild(homeController)
            self.view.addSubview(homeController.view)
            self.vc = homeController
            self.view.bringSubviewToFront(self.backButton)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
}
