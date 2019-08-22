//
//  HotelsTableViewController.swift
//  Hotels
//
//  Created by Артем on 18/08/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

let urlDataHotels = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"

class HotelsTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var hotels = [Hotel]()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity()
        fetchData()
    }

    func activity() {
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        activityIndicator.startAnimating()
    }
    
    //    MARK: - Custom methods
    
    func fetchData() {
        guard let url = URL(string: urlDataHotels) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _)  in
            guard let data = data else { return }
            
            do {
                self.hotels = try JSONDecoder().decode([Hotel].self, from: data)
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
                
                //print(self.hotels)
            } catch let error {
                print(error)
            }
        } .resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HotelsTableViewCell

        let hotel = hotels[indexPath.row]
        
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
    
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue",
            let destination = segue.destination as? DetailHotelViewController,
            let hotelIndex = tableView.indexPathForSelectedRow?.row {
            destination.hotel = hotels[hotelIndex]
        }
    }
    
    //    MARK: - IB Actions
    
    @IBAction func tappedSegmentControl(_ sender: UISegmentedControl) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            fetchData()
        case 1:
            hotels.sort { $0.name < $1.name }
        case 2:
            hotels.sort { $0.distance < $1.distance }
        case 3:
            hotels.sort { $0.suites_availability.components(separatedBy: ":").count > ($1.suites_availability.components(separatedBy: ":").count) }
        default:
            break
        }
        
        tableView.reloadData()
    }
    
}
