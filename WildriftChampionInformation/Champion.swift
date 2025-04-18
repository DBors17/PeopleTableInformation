//
//  Champion.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import Foundation

class Champion{
    var name, position, ultimate, role, image, url: String;
    var gallery : [String];
    
    init(name: String, position: String, ultimate: String, role: String, image: String, url: String, gallery: [String]){
        self.name = name
        self.position = position
        self.ultimate = ultimate
        self.role = role
        self.image = image
        self.url = url
        self.gallery = gallery
    }
}
