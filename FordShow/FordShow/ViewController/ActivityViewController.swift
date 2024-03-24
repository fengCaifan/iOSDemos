//
//  ActivityViewController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/29.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newItemBtn: UIButton!
    @IBOutlet weak var pastItemBtn: UIButton!
    
    var isVideo: Bool = false
    
    var index = 0 {
        didSet {
        }
    }
    
//    var dataSource:[SubjectInfo] = [] {
//        didSet{
//            self.configData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ActiivityCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "ActiivityCollectionViewCell")
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        videoBtnItemAction(self.newItemBtn)
        switchColumn(column, animated: false)
    }
    
    
    lazy var dataSource:[SubjectInfo] = {
        
        let carModel:CarModel = DataSource[index]
        
        var newsubjects:[SubjectObjc] = []
        var pastsubjects:[SubjectObjc] = []
        
        for model in carModel.subjectObjcs {
            if model.type == .new {
                newsubjects.append(model)
            }else{
                pastsubjects.append(model)
            }
        }
        
        var dataSource:[SubjectInfo] = []
        dataSource.append(SubjectInfo(type: .new, subjects: newsubjects))
        dataSource.append(SubjectInfo(type: .past, subjects: pastsubjects))
        return dataSource
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
        switchColumn(column, animated: false)
    }
    
    var column: Int = 0
    
    @IBAction func videoBtnItemAction(_ sender: Any) {
        switchColumn(0)
    }
    
    @IBAction func picBtnItemAction(_ sender: Any) {
        switchColumn(1)
    }
    
    func switchColumn(_ column: Int, animated: Bool = true) {
        let img = UIImage(named: "tab_select")
        self.newItemBtn.setBackgroundImage((column == 0 ? img: nil), for: .normal)
        self.pastItemBtn.setBackgroundImage((column == 1 ? img: nil), for: .normal)
        
        self.newItemBtn.setTitleColor((column == 0 ? UIColor.white: UIColor.hexString(hex: "848484")),
                                      for: .normal)
        
        self.pastItemBtn.setTitleColor((column == 1 ? UIColor.white: UIColor.hexString(hex: "848484")),
                                       for: .normal)
        
        collectionView.scrollToItem(at: IndexPath(item: column, section: 0),
                                    at: .centeredHorizontally,
                                    animated: animated)
        self.column = column
    }
    
    deinit {
        print("ActivityViewController deinit")
    }
    
}

extension ActivityViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActiivityCollectionViewCell",
                                                      for: indexPath) as! ActiivityCollectionViewCell
        if indexPath.row < self.dataSource.count {
            let m = self.dataSource[indexPath.row]
            let style: ColumnStyle = (!isVideo && indexPath.row == 0) ? .double : .single
            cell.set(m, style: style, isVideo: isVideo, didSelectItem: { [unowned self] model in
                
                let detail = ActivityDetailController()
                detail.view.frame = CGRect(x: 0, y: 0, width: contentWidth, height: self.view.bounds.height)
                detail.isVideo = self.isVideo
                detail.source = model

                guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
                    return
                }
                rootVC.addChild(detail)
                rootVC.view.addSubview(detail.view)
                rootVC.view.bringSubviewToFront(detail.view)
            })
        }
        
        return cell
    }
    
}

extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
