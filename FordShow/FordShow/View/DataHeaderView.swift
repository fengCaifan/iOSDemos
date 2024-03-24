//
//  DataHeaderView.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

class DataHeaderView: UITableViewHeaderFooterView {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
    }

}
