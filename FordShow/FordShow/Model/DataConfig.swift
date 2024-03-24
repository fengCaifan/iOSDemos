//
//  DataConfig.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

let menuWidth: CGFloat = UIScreen.main.bounds.width/6

let contentWidth: CGFloat = UIScreen.main.bounds.width*5/6

let contentHeight: CGFloat = UIScreen.main.bounds.height

let DataSource = [CarModel(data:raptorDataSource,pics:raptorPicData,price: raptorPriceData,video:raptorVideoData,subjectObjcs:raptorSubjectObjc),
                  CarModel(data:mustangDataSource,pics:mustangPicData,price: mustangPriceData,video:mustangVideoData,subjectModel:mustangSubjectModel),
                  CarModel(data:explorerDataSource,pics:explorerPicData,price: explorerPriceData,video:explorerVideoData,subjectModel:explorerSubjectModel),
                  CarModel(data:rangerDataSource,pics:rangerPicData,price: rangerPriceData,video:rangerVideoData,subjectObjcs:rangerSubjectObjc)]

//Raptor-data-12
let raptorDataSource = [
    DataModel(config:"Raptor-data",header: "Raptor-data-0", list: ["Raptor-data-00"]),
//    DataModel(config:"Raptor-data",header: "Raptor-data-1", list: ["Raptor-data-10", "Raptor-data-11"]),
//    DataModel(config:"Raptor-data",header: "Raptor-data-2", list: ["Raptor-data-20", "Raptor-data-21", "Raptor-data-22"]),
////    DataModel(config:"Raptor-data",header: "Raptor-data-3", list: []),
//    DataModel(config:"Raptor-data",header: "Raptor-data-4", list: ["Raptor-data-40", "Raptor-data-41"]),
//    DataModel(config:"Raptor-data",header: "Raptor-data-5", list: ["Raptor-data-50", "Raptor-data-51"]),
//    DataModel(config:"Raptor-data",header: "Raptor-data-6", list: ["Raptor-data-60", "Raptor-data-61", "Raptor-data-62"]),
//    DataModel(config:"Raptor-data",header: "Raptor-data-7", list: ["Raptor-data-70", "Raptor-data-71"]),
]
let raptorPicData = [
    PicModel(list: ["Raptor-pic01","Raptor-pic02","Raptor-pic03","Raptor-pic04","Raptor-pic05","Raptor-pic06","Raptor-pic07","Raptor-pic08","Raptor-pic09","Raptor-pic10","Raptor-pic11","Raptor-pic12","Raptor-pic13","Raptor-pic14","Raptor-pic15", "Raptor-pic16"])
]
let raptorPriceData = [
    PriceModel(list: ["Raptor-price-pic01","Raptor-price-pic02", "Raptor-price-pic03", "Raptor-price-pic04", "Raptor-price-pic05"])
]
let raptorVideoData = [
    vidoeModel(list: ["Raptor-video01","Raptor-video02"])
]

let raptorSubjectModel = SubjectModel(img:[], video:[])


let raptorSubjectObjc = [
    SubjectObjc(type: .new, imgtuples: ["new_raptor_pic01","new_raptor_pic02","new_raptor_pic03","new_raptor_pic04","new_raptor_pic05","new_raptor_pic06","new_raptor_pic07","new_raptor_pic08","new_raptor_pic09","new_raptor_pic10","new_raptor_pic11","new_raptor_pic12","new_raptor_pic13","new_raptor_pic14","new_raptor_pic15","new_raptor_pic16","new_raptor_pic17","new_raptor_pic18","new_raptor_pic19","new_raptor_pic20","new_raptor_pic21","new_raptor_pic22","new_raptor_pic23","new_raptor_pic24","new_raptor_pic25","new_raptor_pic26","new_raptor_pic27"], videotuples: [("承包天与地","new_raptor_cb_01"),("越野篇","new_raptor_yy_01"),("追逐篇","new_raptor_zz_01"),("茨中村","new_raptor_cz_01")], site: nil),
    SubjectObjc(type: .past, imgtuples: ["past_raptor_hn_pic01","past_raptor_hn_pic02","past_raptor_hn_pic03","past_raptor_hn_pic04","past_raptor_hn_pic05","past_raptor_hn_pic06","past_raptor_hn_pic07","past_raptor_hn_pic08","past_raptor_hn_pic09","past_raptor_hn_pic10","past_raptor_hn_pic11","past_raptor_hn_pic12","past_raptor_hn_pic13","past_raptor_hn_pic14","past_raptor_hn_pic15","past_raptor_hn_pic16","past_raptor_hn_pic17","past_raptor_hn_pic18","past_raptor_hn_pic19","past_raptor_hn_pic20"], videotuples: [("品牌篇","past_raptor_hn_pp"),("车主篇","past_raptor_hn_cz")], site: "海南站",imgsCover:"past_raptor_hn_imgCover",videoCover:"past_raptor_hn_videoCover"),
    SubjectObjc(type: .past, imgtuples: ["past_raptor_als_pic01","past_raptor_als_pic02","past_raptor_als_pic03","past_raptor_als_pic04","past_raptor_als_pic05","past_raptor_als_pic06","past_raptor_als_pic07","past_raptor_als_pic08","past_raptor_als_pic09","past_raptor_als_pic10","past_raptor_als_pic11","past_raptor_als_pic12","past_raptor_als_pic13","past_raptor_als_pic14","past_raptor_als_pic15","past_raptor_als_pic16"], videotuples: [("品牌篇","past_raptor_als_pp")], site: "阿拉善站",imgsCover:"past_raptor_als_imgCover",videoCover:"past_raptor_als_videoCover"),
    SubjectObjc(type: .past, imgtuples: ["past_raptor_lh_pic01","past_raptor_lh_pic02","past_raptor_lh_pic03","past_raptor_lh_pic04","past_raptor_lh_pic05","past_raptor_lh_pic06","past_raptor_lh_pic07","past_raptor_lh_pic08","past_raptor_lh_pic09","past_raptor_lh_pic10","past_raptor_lh_pic11","past_raptor_lh_pic12","past_raptor_lh_pic13","past_raptor_lh_pic14","past_raptor_lh_pic15","past_raptor_lh_pic16"], videotuples: [("品牌篇","past_raptor_lh_pp"),("车主篇","past_raptor_lh_cz")], site: "冷湖站",imgsCover:"past_raptor_lh_imgCover",videoCover:"past_raptor_lh_videoCover")
]

let rangerSubjectObjc = [
    SubjectObjc(type: .new, imgtuples: ["new_raptor_pic01","new_raptor_pic02","new_raptor_pic03","new_raptor_pic04","new_raptor_pic05","new_raptor_pic06","new_raptor_pic07","new_raptor_pic08","new_raptor_pic09","new_raptor_pic10","new_raptor_pic11","new_raptor_pic12","new_raptor_pic13","new_raptor_pic14","new_raptor_pic15","new_raptor_pic16","new_raptor_pic17","new_raptor_pic18","new_raptor_pic19","new_raptor_pic20","new_raptor_pic21","new_raptor_pic22","new_raptor_pic23","new_raptor_pic24","new_raptor_pic25","new_raptor_pic26","new_raptor_pic27"], videotuples: [("承包天与地","new_raptor_cb_01"),("越野篇","new_raptor_yy_01"),("追逐篇","new_raptor_zz_01"),("茨中村","new_raptor_cz_01")], site: nil),
    SubjectObjc(type: .past, imgtuples: ["past_raptor_hn_pic01","past_raptor_hn_pic02","past_raptor_hn_pic03","past_raptor_hn_pic04","past_raptor_hn_pic05","past_raptor_hn_pic06","past_raptor_hn_pic07","past_raptor_hn_pic08","past_raptor_hn_pic09","past_raptor_hn_pic10","past_raptor_hn_pic11","past_raptor_hn_pic12","past_raptor_hn_pic13","past_raptor_hn_pic14","past_raptor_hn_pic15","past_raptor_hn_pic16","past_raptor_hn_pic17","past_raptor_hn_pic18","past_raptor_hn_pic19","past_raptor_hn_pic20"], videotuples: [("品牌篇","past_raptor_hn_pp"),("车主篇","past_raptor_hn_cz")], site: "海南站",imgsCover:"past_raptor_hn_imgCover",videoCover:"past_raptor_hn_videoCover"),
    SubjectObjc(type: .past, imgtuples: ["past_raptor_als_pic01","past_raptor_als_pic02","past_raptor_als_pic03","past_raptor_als_pic04","past_raptor_als_pic05","past_raptor_als_pic06","past_raptor_als_pic07","past_raptor_als_pic08","past_raptor_als_pic09","past_raptor_als_pic10","past_raptor_als_pic11","past_raptor_als_pic12","past_raptor_als_pic13","past_raptor_als_pic14","past_raptor_als_pic15","past_raptor_als_pic16"], videotuples: [("品牌篇","past_raptor_als_pp")], site: "阿拉善站",imgsCover:"past_raptor_als_imgCover",videoCover:"past_raptor_als_videoCover"),
    SubjectObjc(type: .past, imgtuples: ["past_raptor_lh_pic01","past_raptor_lh_pic02","past_raptor_lh_pic03","past_raptor_lh_pic04","past_raptor_lh_pic05","past_raptor_lh_pic06","past_raptor_lh_pic07","past_raptor_lh_pic08","past_raptor_lh_pic09","past_raptor_lh_pic10","past_raptor_lh_pic11","past_raptor_lh_pic12","past_raptor_lh_pic13","past_raptor_lh_pic14","past_raptor_lh_pic15","past_raptor_lh_pic16"], videotuples: [("品牌篇","past_raptor_lh_pp"),("车主篇","past_raptor_lh_cz")], site: "冷湖站",imgsCover:"past_raptor_lh_imgCover",videoCover:"past_raptor_lh_videoCover")
]


let mustangDataSource = [
    DataModel(config:"Mustang-data",header: "Mustang-data-0", list: ["Mustang-data-00"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-1", list: ["Mustang-data-10","Mustang-data-11"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-2", list: ["Mustang-data-20"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-3", list: ["Mustang-data-30"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-4", list: ["Mustang-data-40", "Mustang-data-41"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-5", list: ["Mustang-data-50", "Mustang-data-51", "Mustang-data-52"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-6", list: ["Mustang-data-60"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-7", list: ["Mustang-data-70"]),
    DataModel(config:"Mustang-data",header: "Mustang-data-8", list: ["Mustang-data-80", "Mustang-data-81"]),
]
let mustangPicData = [
    PicModel(list: ["Mustang-Pic01","Mustang-Pic02","Mustang-Pic03","Mustang-Pic04","Mustang-Pic05","Mustang-Pic06","Mustang-Pic07","Mustang-Pic08","Mustang-Pic09","Mustang-Pic10","Mustang-Pic11","Mustang-Pic12","Mustang-Pic13","Mustang-Pic14"])
]
let mustangPriceData = [
    PriceModel(list: ["Mustang-price-pic01","Mustang-price-pic02"])
]
let mustangVideoData = [
    vidoeModel(list: ["Mustang-video01","Mustang-video02","Mustang-video03","Mustang-video04","Mustang-video05","Mustang-video06"])
]
let mustangSubjectModel = SubjectModel(img:[], video:[])

let explorerDataSource = [
    DataModel(config:"Explorer-data", header: "Explorer-data-0", list: ["Explorer-data-00", "Explorer-data-01"]),
    DataModel(config:"Explorer-data", header: "Explorer-data-1", list: ["Explorer-data-10", "Explorer-data-11"]),
    DataModel(config:"Explorer-data", header: "Explorer-data-2", list: ["Explorer-data-20", "Explorer-data-21", "Explorer-data-22"]),
    DataModel(config:"Explorer-data", header: "Explorer-data-3", list: ["Explorer-data-30"]),
    DataModel(config:"Explorer-data", header: "Explorer-data-4", list: ["Explorer-data-40", "Explorer-data-41", "Explorer-data-42"]),
    DataModel(config:"Explorer-data", header: "Explorer-data-5", list: ["Explorer-data-50", "Explorer-data-51"]),
    
]
let explorerPicData = [
    PicModel(list: ["Explorer-pic01","Explorer-pic02","Explorer-pic03","Explorer-pic04","Explorer-pic05","Explorer-pic07","Explorer-pic08","Explorer-pic09","Explorer-pic10","Explorer-pic11","Explorer-pic12","Explorer-pic13","Explorer-pic14", "Explorer-pic15"])
]
let explorerPriceData = [
    PriceModel(list: ["Explorer-price-pic01","Explorer-price-pic02","Explorer-price-pic03","Explorer-price-pic04","Explorer-price-pic05","Explorer-price-pic06"])
]
let explorerVideoData = [
    vidoeModel(list: ["Explorer-video01","Explorer-video02"])
]

let explorerSubjectModel = SubjectModel(img:[], video:[])

let rangerDataSource = [
    DataModel(config:"Ranger-data",header: "Ranger-data-0", list: ["Ranger-data-00"]),
    DataModel(config:"Ranger-data",header: "Ranger-data-1", list: ["Ranger-data-10", "Ranger-data-11"]),
    DataModel(config:"Ranger-data",header: "Ranger-data-2", list: ["Ranger-data-20"]),
    DataModel(config:"Ranger-data",header: "Ranger-data-3", list: ["Ranger-data-30","Ranger-data-31","Ranger-data-32"]),
    DataModel(config:"Ranger-data",header: "Ranger-data-4", list: ["Ranger-data-40"]),
    DataModel(config:"Ranger-data",header: "Ranger-data-5", list: ["Ranger-data-50", "Ranger-data-51", "Ranger-data-52"]),
    DataModel(config:"Ranger-data",header: "Ranger-data-6", list: ["Ranger-data-60", "Ranger-data-61", "Ranger-data-62", "Ranger-data-63", "Ranger-data-64"]),
]
let rangerPicData = [
    PicModel(list: ["Ranger-pic01","Ranger-pic02","Ranger-pic03","Ranger-pic04","Ranger-pic05","Ranger-pic06","Ranger-pic07","Ranger-pic08","Ranger-pic09","Ranger-pic10","Ranger-pic11","Explorer-pic12","Ranger-pic13","Ranger-pic14", "Ranger-pic15", "Ranger-pic16"])
]
let rangerPriceData = [
    PriceModel(list: ["Ranger-price-pic01"])
]
let rangerVideoData = [
    vidoeModel(list: ["Ranger-video01","Ranger-video02","Ranger-video03","Ranger-video04","Ranger-video05","Ranger-video06","Ranger-video07","Ranger-video08","Ranger-video09","Ranger-video10","Ranger-video11"])
]
let rangerSubjectModel = SubjectModel(img:[], video:[])
