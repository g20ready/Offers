//
//  Offer.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit
import ObjectMapper

class Offer: Mappable {

    var category: String?
    var title: String?
    var image: String?
    var price: String?
    var company: String?
    
    required init?(map: Map) { }
    
    // Mappable
    func mapping(map: Map) {
        category        <- map["category"]
        title           <- map["title"]
        image           <- map["image"]
        price           <- map["price"]
        company         <- map["company"]
    }
}
