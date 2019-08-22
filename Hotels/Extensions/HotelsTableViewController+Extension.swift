//
//  HotelsTableViewController+Extension.swift
//  Hotels
//
//  Created by Артем on 22/08/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension HotelsTableViewController {
    func configure(cell: HotelsTableViewCell, with hotel: Hotel) {
        
        cell.labelName.text = hotel.name
        cell.labelAddress.text = "Address: \(hotel.address)"
        
        switch hotel.stars {
        case 1:
            cell.labelStars.text = "⭐️"
        case 2:
            cell.labelStars.text = "⭐️⭐️"
        case 3:
            cell.labelStars.text = "⭐️⭐️⭐️"
        case 4:
            cell.labelStars.text = "⭐️⭐️⭐️⭐️"
        case 5:
            cell.labelStars.text = "⭐️⭐️⭐️⭐️⭐️"
        default:
            cell.labelStars.text = "n/a"
        }
        
        if hotel.distance > 0.0 && hotel.distance < 450.0  {
            cell.labelDistance.textColor = .green
        } else if hotel.distance >= 450 && hotel.distance < 900 {
            cell.labelDistance.textColor = .blue
        } else if hotel.distance >= 900 {
            cell.labelDistance.textColor = .red
        }
        
        cell.labelDistance.text = "Distance: \(hotel.distance.description) m"
        
        let availableRooms = hotel.suites_availability.components(separatedBy: ":").count
        if availableRooms >= 0 && availableRooms < 3 {
            cell.labelRoom.textColor = .red
        } else if availableRooms >= 3 && availableRooms < 7 {
            cell.labelRoom.textColor = .blue
        } else if availableRooms > 7 {
            cell.labelRoom.textColor = .green
        }
        
        cell.labelRoom.text = "Available: \(String(describing: availableRooms)) suites"
    }
}
