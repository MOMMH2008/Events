//
//  LoadingCell.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
