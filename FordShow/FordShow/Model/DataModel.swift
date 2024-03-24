//
//  DataModel.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

//图片数据
struct PicModel {
    var items:[String] = [] //图片名称
    
    init(list:[String]) {
        self.items = list
    }
}

//专题视频数据
struct vidoeModel {
    var items:[String] = [] //视频名称
    init(list:[String]) {
        self.items = list
    }
}

//参数数据
struct DataModel {
    var config = ""
    var header = ""
    var items: [String] = [String]()
    
    init(config: String, header: String, list: [String]) {
        self.config = config
        self.header = header
        self.items = list
    }
}

//价格数据
struct PriceModel {
    var items:[String] = [] //对应的图片
    init(list:[String]) {
        self.items = list
    }
}

//专题活动

enum SubjectType {
    case new
    case past
}

//每个地点的视频和音频，如果没有地点，则是所有的视频和音频
struct SubjectObjc {
    var type:SubjectType = .new
    var site:String? //地点
    var imgtuples:[String] = []
    var videotuples:[(String,String)] = []
    var imgsCover:String? //每个站点对应的图片w封面
    var videoCover:String? //每个站点对应的视频封面
    init(type:SubjectType,imgtuples:[String],videotuples:[(String,String)],site:String? = nil,imgsCover:String? = nil,videoCover:String? = nil) {
        self.type = type;
        self.site = site
        self.imgtuples = imgtuples
        self.videotuples = videotuples
        self.imgsCover = imgsCover
        self.videoCover = videoCover
    }
}

struct SubjectInfo {
    var type:SubjectType = .new
    var subjects:[SubjectObjc] = []
    init(type:SubjectType,subjects:[SubjectObjc]) {
        self.type = type
        self.subjects = subjects
    }
}

struct SubjectModel {
    var img:[String] = [] //对应图片
    var video:[String] = [] //对应视频
    init(img:[String], video:[String]) {
        self.img = img
        self.video = video
    }
}






//总数据
struct CarModel {
    var data:[DataModel] = [] //参数数据
    var pics:[PicModel] = [] //
    var price:[PriceModel] = []
    var video:[vidoeModel] = []
    
    var subjectModel:SubjectModel? //
    var subjectObjcs:[SubjectObjc] = []
    
    init(data:[DataModel], pics:[PicModel], price:[PriceModel],video:[vidoeModel],subjectObjcs:[SubjectObjc]=[],subjectModel:SubjectModel?=nil) {
        self.data = data
        self.pics = pics
        self.price = price
        self.video = video
        self.subjectObjcs = subjectObjcs
        self.subjectModel = subjectModel
    }
    
}
