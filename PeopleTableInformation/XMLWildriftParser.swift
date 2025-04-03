//
//  XMLPeopleParser.swift
//  PeopleTableInformation
//
//  Created by Dorin on 29.03.2025.
//

import Foundation

class XMLWildriftParser: NSObject, XMLParserDelegate{
    var name:String
    
    init(name:String){
        self.name = name
    }
    
    //MARK: --var declaration
    
    var pName, pPosition, pUltimate, pRole, pImage, pUrl : String!
    
    var passData   = false
    var passElement = -1
    
    var championData : Champion!
    var wildriftData = [Champion]()
    
    var parser : XMLParser!
    
    var tags  = ["name", "position", "ultimate", "role", "image", "url"]
    
    //MARK: -- parser delegate methods
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        // check spys to see if string data is important and save
        
        if passData{
            switch passElement{
            case 0 : pName = string
            case 1 : pPosition = string
            case 2 : pUltimate = string
            case 3 : pRole = string
            case 4 : pImage = string
            case 5 : pUrl = string
            default : break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //set the spys based on elementName if in tags
        
        if tags.contains(elementName){
            passData = true
            passElement = tags.firstIndex(of: elementName)!
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //reset spys if element name in tags
        
        if tags.contains(elementName){
            passData = false
            passElement = -1
        }
        
        if elementName == "champion"{
            championData = Champion(name: pName, position: pPosition, ultimate: pUltimate, role: pRole, image: pImage, url: pUrl)
            wildriftData.append(championData)
        }
    }
    
    func startParsing(){
        //get the xml file url
        let bundleUrl = Bundle.main.bundleURL
        let xmlFileUrl = URL(string: self.name, relativeTo: bundleUrl)
        
        parser = XMLParser(contentsOf: xmlFileUrl!)
        parser.delegate = self
        parser.parse()
    }
    
}
