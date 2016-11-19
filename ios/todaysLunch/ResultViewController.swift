//
//  ResultViewController.swift
//  todaysLunch
//
//  Created by admin on 2016/11/06.
//  Copyright © 2016年 edu.self. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var item: FoodItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Result"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // image
        let imgData = try! Data(contentsOf:URL(string:item.imgURL)!)
        let imgView=UIImageView(image:UIImage(data:imgData))
        let with  = 300 * self.view.bounds.width  / 320
        let hight = 300 * self.view.bounds.height / 568
        let x     = self.view.bounds.width  / 2 - with  / 2
        let y     = self.view.bounds.height / 2 - hight / 2
        imgView.frame = CGRect(x: x, y: y, width: with, height: hight)
        self.view.addSubview(imgView)
        
        // name
        let nameLabel = UILabel()
        nameLabel.text = item.name
        nameLabel.font = UIFont(name: "HiraMinProN-W3", size: 20)
        nameLabel.sizeToFit()
        nameLabel.center = CGPoint(x: self.view.bounds.width / 2, y: 90)
        self.view.addSubview(nameLabel)
        
        // rarity
        let rarityLabel = UILabel()
        rarityLabel.text = item.rarity
        rarityLabel.font = UIFont(name: "HiraMinProN-W6", size: 40)
        rarityLabel.textColor = UIColor.yellow
        rarityLabel.sizeToFit()
        rarityLabel.center = CGPoint(x: self.view.bounds.width / 2, y: 120)
        self.view.addSubview(rarityLabel)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
