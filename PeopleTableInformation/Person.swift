//
//  Person.swift
//  PeopleTableInformation
//
//  Created by Dorin on 29.03.2025.
//

import Foundation

class Person{
    var name, phone, email, image, url: String;
    
    init(name: String, phone: String, email: String, image: String, url: String){
        self.name = name
        self.phone = phone
        self.email = email
        self.image = image
        self.url = url
    }
}
