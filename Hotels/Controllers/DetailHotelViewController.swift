//
//  DetailHotelViewController.swift
//  Hotels
//
//  Created by Артем on 18/08/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

let baseUrl = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/"
let baseUrlImage = "https://github.com/iMofas/ios-android-test/raw/master/"

class DetailHotelViewController: UIViewController {
    
    var hotel: Hotel?
    
    //    MARK : - IB Outlets
    
    @IBOutlet weak var imageHotel: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelSuits: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelCoordinat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDataHotel()
    }

    // MARK: - Custom methods
    
    private func fetchDataHotel() {
        
        let hotelUrl = hotel?.id
        
        guard let url = URL(string: "\(baseUrl)"+"\(hotelUrl!)"+".json") else {
            print("URL is incorrect")
            return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _)  in
            guard let data = data else { return }
            
            do {
                self.hotel = try JSONDecoder().decode(Hotel.self, from: data)
                
                if self.hotel?.image != nil {
                    self.fetchImage(url: (self.hotel?.image)!)
                } else {
                    
                    DispatchQueue.main.async {
                        self.imageHotel.backgroundColor = .darkGray
                    }
                }
                
                DispatchQueue.main.async {
                    self.setupUI()
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
   private func fetchImage(url: String) {
        
        guard let urlImage = URL(string: "\(baseUrlImage)"+"\(url)") else {
            print("URL is incorrect")
            return }
        
        URLSession.shared.dataTask(with: urlImage) { (data, _, _)  in
            if let data = data, let image = UIImage(data: data) {
                
                    DispatchQueue.main.async {
                        self.imageHotel.image = image.crop(rect: CGRect(x: 1, y: 1, width: image.size.width - 2, height: image.size.height - 2))
                    }
                }
    }.resume()
}

    private func setupUI() {
        
        switch hotel!.stars {
        case 1:
            labelRating.text = "⭐️"
        case 2:
            labelRating.text = "⭐️⭐️"
        case 3:
            labelRating.text = "⭐️⭐️⭐️"
        case 4:
            labelRating.text = "⭐️⭐️⭐️⭐️"
        case 5:
            labelRating.text = "⭐️⭐️⭐️⭐️⭐️"
        default:
            labelRating.text = "n/a"
        }
        
        self.labelName.text = self.hotel?.name
        self.labelAddress.text = self.hotel?.address
        
        if hotel!.distance > 0 && hotel!.distance < 450 {
            labelDistance.textColor = .green
        } else if hotel!.distance >= 450 && hotel!.distance < 900 {
            labelDistance.textColor = .blue
        } else if hotel!.distance >= 900 {
            labelDistance.textColor = .red
        }
        
        self.labelDistance.text = "Distance: " + (hotel?.distance.description)! + " m"
        
        let availableRooms = hotel!.suites_availability.components(separatedBy: ":").count
        if availableRooms >= 0 && availableRooms < 3 {
            labelSuits.textColor = .red
        } else if availableRooms >= 3 && availableRooms < 7 {
            labelSuits.textColor = .blue
        } else if availableRooms > 7 {
            labelSuits.textColor = .green
        }
        
        labelSuits.text = "Available: \(String(describing: availableRooms)) suites"
        
        self.labelCoordinat.text = String((hotel?.lat?.description)! + ", " + (hotel?.lon?.description)!)
        }
    }



