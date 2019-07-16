//
//  Child2ViewController.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)
        label.textColor = UIColor(red: 95/255, green: 102/255, blue: 108/255, alpha: 1)
        label.text = title
        label.sizeToFit()
        
        view.addSubview(label)
        view.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
