//
//  HomeViewController.swift
//  FordShow
//
//  Created by xinyue on 2019/5/8.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var index: Int = 0 {
        didSet{
            if index == 0 {
                imageVIew.image = UIImage(named: "mengqin_home")
            }else if index == 1 {
                imageVIew.image = UIImage(named: "mustang_home")
            }else if index == 2 {
                imageVIew.image = UIImage(named: "tanxianzhe_home")
            }else if index == 3 {
                imageVIew.image = UIImage(named: "ranger_home")
            }
        }
    }
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor = UIColor.clear
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
