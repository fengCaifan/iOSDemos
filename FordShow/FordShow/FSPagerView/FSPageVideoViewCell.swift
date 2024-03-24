//
//  FSPageVideoViewCell.swift
//  FordShow
//
//  Created by 冯才凡 on 2019/5/8.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

class FSPageVideoViewCell: FSPagerViewCell {
    
    lazy var iconImgView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "bigplay"))
        img.frame = CGRect(x: (self.frame.width-80)/2.0, y: (self.frame.height-80)/2.0, width: 80, height: 80)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.iconImgView)
        self.bringSubviewToFront(self.iconImgView)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.iconImgView.frame = CGRect(x: (self.frame.width-80)/2.0, y: (self.frame.height-80)/2.0, width: 80, height: 80)
        self.iconImgView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        
    }
}
