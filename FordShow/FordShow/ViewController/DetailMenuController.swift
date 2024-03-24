//
//  DetailMenuController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit


class DetailMenuController: UIViewController {

    @IBOutlet weak var svWidth: NSLayoutConstraint!
    @IBOutlet weak var wgBtn: UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var csBtn: UIButton!
    @IBOutlet weak var priceBtn: UIButton!
    @IBOutlet weak var subjectBtn: UIButton!
    
//    var lastBtn:UIButton!
    
    var menuBtnAction:((_ index:Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wgBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .selected)
        wgBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .highlighted)
        wgBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.5)), for: .normal)

        

        videoBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .selected)
        videoBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .highlighted)
        videoBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.5)), for: .normal)

        csBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .selected)
        csBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .highlighted)
        csBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.5)), for: .normal)

        priceBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .selected)
        priceBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .highlighted)
        priceBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.5)), for: .normal)

        subjectBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .selected)
        subjectBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.7)), for: .highlighted)
        subjectBtn.setBackgroundImage(self.creatImageWithColor(color: UIColor(white: 0, alpha: 0.5)), for: .normal)
        
        self.view.backgroundColor = UIColor.clear
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.svWidth.constant = menuWidth
    }
    
    //外观内饰
    @IBAction func WGBtnAction(_ sender: Any) {
        self.wgBtn.isSelected = true
        self.videoBtn.isSelected = false
        self.csBtn.isSelected = false
        self.priceBtn.isSelected = false
        self.subjectBtn.isSelected = false
        
        self.menuBtnAction?(0)
    }
    
    //专题视频
    @IBAction func videoBtn(_ sender: Any) {
        
        self.wgBtn.isSelected = false
        self.videoBtn.isSelected = true
        self.csBtn.isSelected = false
        self.priceBtn.isSelected = false
        self.subjectBtn.isSelected = false
        
        self.menuBtnAction?(1)
    }
    
    //车型参数
    @IBAction func CSBtnAction(_ sender: Any) {

        self.wgBtn.isSelected = false
        self.videoBtn.isSelected = false
        self.csBtn.isSelected = true
        self.priceBtn.isSelected = false
        self.subjectBtn.isSelected = false
        
        self.menuBtnAction?(2)
    }
    
    //官方指导价
    @IBAction func priceBtnAction(_ sender: Any) {
        
        self.wgBtn.isSelected = false
        self.videoBtn.isSelected = false
        self.csBtn.isSelected = false
        self.priceBtn.isSelected = true
        self.subjectBtn.isSelected = false
        
        self.menuBtnAction?(3)
    }
    
    //专题活动
    @IBAction func topicBtnAction(_ sender: Any) {
        
        self.wgBtn.isSelected = false
        self.videoBtn.isSelected = false
        self.csBtn.isSelected = false
        self.priceBtn.isSelected = false
        self.subjectBtn.isSelected = true
        
        self.menuBtnAction?(4)
    }
    
    
    func creatImageWithColor(color:UIColor)->UIImage{
        let w:CGFloat = UIScreen.main.bounds.width/6.0
        let h:CGFloat = UIScreen.main.bounds.height/5.0
        
        let rect = CGRect(x:0,y:0,width:w,height:h)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
