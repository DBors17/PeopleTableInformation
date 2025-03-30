//
//  People.swift
//  PeopleTableInformation
//
//  Created by Dorin on 29.03.2025.
//

import Foundation

class People{
    var peopleData : [Person]
    
    init(name:String){
        //make a parser and start parsing
        let parser = XMLPeopleParser(name: name)
        parser.startParsing()
        
        //get people data from parser
        self.peopleData = parser.peopleData
    }
    
    func getCount()->Int{return self.peopleData.count}
    func getPerson(index:Int)->Person{return self.peopleData[index]}
}
