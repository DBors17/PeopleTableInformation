//
//  Person.swift
//  PeopleTableInformation
//
//  Created by Dorin on 29.03.2025.
//

import Foundation

class Champion{
    var name, position, ultimate, role, image, url: String;
    
    init(name: String, position: String, ultimate: String, role: String, image: String, url: String){
        self.name = name
        self.position = position
        self.ultimate = ultimate
        self.role = role
        self.image = image
        self.url = url
    }
}
