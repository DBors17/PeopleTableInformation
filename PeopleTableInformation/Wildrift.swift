//
//  Wildrift.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import Foundation

class Wildrift{
    var wildriftData : [Champion]
    
    init(name:String){
        //make a parser and start parsing
        let parser = XMLWildriftParser(name: name)
        parser.startParsing()
        
        //get people data from parser
        self.wildriftData = parser.wildriftData
    }
    
    func getCount()->Int{return self.wildriftData.count}
    func getChampion(index:Int)->Champion{return self.wildriftData[index]}
}
