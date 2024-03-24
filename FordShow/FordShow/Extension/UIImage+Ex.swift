//
//  UIImage+Ex.swift
//  FordShow
//
//  Created by xinyue on 2019/5/31.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

enum UIImageExt: String {
    case png = "png"
    case jpg = "jpg"
    case jpeg = "jpeg"
}

extension UIImage {
    
    convenience init?(named: String, ext: UIImageExt = .png) {
        if let path = Bundle.main.path(forResource: named, ofType: ext.rawValue) {
            self.init(contentsOfFile: path)
        }else if let path = Bundle.main.path(forResource: named, ofType: UIImageExt.jpg.rawValue) {
            self.init(contentsOfFile: path)
        }else if let path = Bundle.main.path(forResource: named, ofType: UIImageExt.jpeg.rawValue) {
            self.init(contentsOfFile: path)
        }else{
            fatalError("图片路径错误：\(named).\(ext.rawValue)")
        }
    }
}
