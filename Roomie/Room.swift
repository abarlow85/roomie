//
//  Room.swft.swift
//  Roomie
//
//  Created by Nigel Koh on 5/18/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import Foundation

class Room {
    var category : String
    var name : String
    
    init(category: String, name: String) {
        self.category = category
        self.name = name
    }
}