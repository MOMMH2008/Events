//
//  EventCellTableViewCell.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit
import Kingfisher
class EventCellTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var statDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var eventPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setcell(event: ModelEvent) {
        eventPhoto.image = nil
        eventNameLabel.text = event.name
        statDateLabel.text = "Start : " + (event.startDate ?? "")
        endDateLabel.text = "End : " +  (event.endDate ?? "")
        if let photoUrl = event.cover {
            eventPhoto.kf.setImage(with: URL(string: photoUrl))
        }
    }
}
