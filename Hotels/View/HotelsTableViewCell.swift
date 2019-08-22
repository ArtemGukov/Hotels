//
//  HotelsTableViewCell.swift
//  Hotels
//
//  Created by Артем on 18/08/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class HotelsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelStars: UILabel!
    @IBOutlet weak var labelRoom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
