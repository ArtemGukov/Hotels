//
//  Model.swift
//  Hotels
//
//  Created by Артем on 18/08/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import Foundation

struct Hotel: Decodable {
    
    let id: Int
    let name: String
    let address: String
    let stars: Int
    let distance: Float
    let image: String?
    let suites_availability: String
    let lat: Float?
    let lon: Float?
}
