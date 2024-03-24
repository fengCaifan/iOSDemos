//
//  DataViewController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/7.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    var dataSource: [DataModel]!{
        didSet{
            if let first:DataModel = dataSource.first {
                configImg.image = UIImage(named: first.config)
            }
        }
    }
    
    @IBOutlet weak var configImg: UIImageView!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
            self.tableView.register(DataHeaderView.self, forHeaderFooterViewReuseIdentifier: "DataHeaderView")
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
    }
}

extension DataViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = dataSource[section]
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        let model = dataSource[indexPath.section]
        cell.coverImageView.image = UIImage(named: model.items[indexPath.row])
        return cell
    }
}

extension DataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DataHeaderView") as! DataHeaderView
        let model = dataSource[section]
        view.imageView.image = UIImage(named: model.header)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.section]
        let img = UIImage(named: model.items[indexPath.row]) ?? UIImage()
        let height = img.size.height/img.size.width * tableView.frame.width
        return height > 0 ? height : 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = dataSource[section]
        let img = UIImage(named: model.header) ?? UIImage()
        let height = img.size.height/img.size.width * tableView.frame.width
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
}
