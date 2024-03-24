//
//  VideoTopTouchLayer.swift
//  FordShow
//
//  Created by 冯才凡 on 2019/5/9.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

protocol VideoTopTouchLayerDelegate:NSObjectProtocol {
    func touchesBeganWithPoint(point:CGPoint?)
    func touchesEndedWithPoint(point:CGPoint?)
    func touchesMovedWithPoint(point:CGPoint?)
}

//视频上层播放的手势层 frame 应该设置成和播放器一样
class VideoTopTouchLayer: UIButton {

    weak var touchDelegate:VideoTopTouchLayerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first?.location(in: self)
        self.touchDelegate?.touchesBeganWithPoint(point: touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let touch = touches.first?.location(in: self)
        self.touchDelegate?.touchesEndedWithPoint(point: touch)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first?.location(in: self)
        self.touchDelegate?.touchesMovedWithPoint(point: touch)
    }
}
