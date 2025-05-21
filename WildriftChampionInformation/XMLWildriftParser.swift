//
//  XMLPeopleParser.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import Foundation
import UIKit
import CoreData

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
    
    var galleryImages: [String] = []
    var insideGallery = false
    
    var parser : XMLParser!
    
    var tags  = ["name", "position", "ultimate", "role", "image", "url"]
    
    //MARK: -- parser delegate methods
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        // check spys to see if string data is important and save
        
        if passData{
            if insideGallery && passElement == -1 {
                galleryImages.append(string.trimmingCharacters(in: .whitespacesAndNewlines))
            }else{
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
}
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "gallery"{
            insideGallery = true
            galleryImages = []
        }
        
        //set the spys based on elementName if in tags
        
        if tags.contains(elementName) || (insideGallery && elementName == "img"){
            passData = true
            passElement = tags.firstIndex(of: elementName) ?? -1
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //reset spys if element name in tags
        
        if tags.contains(elementName) || (insideGallery && elementName == "img"){
            passData = false
            passElement = -1
        }
        
        if elementName == "gallery"{
            insideGallery = false
        }
        
        if elementName == "champion"{
            championData = Champion(name: pName,
                                    position: pPosition,
                                    ultimate: pUltimate,
                                    role: pRole,
                                    image: pImage,
                                    url: pUrl,
                                    gallery: galleryImages)
            wildriftData.append(championData)
        }
    }
    
    func startParsing(){
        //get the xml file url
        guard let xmlFileUrl = Bundle.main.url(forResource: self.name, withExtension: "xml") else {
            print("XML file not found")
            return
        }

        
        parser = XMLParser(contentsOf: xmlFileUrl)
        parser.delegate = self
        parser.parse()
    }
    
    
    func saveToCoreDataIfNeeded() {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<CDChampion> = CDChampion.fetchRequest()
            if let count = try? context.count(for: fetchRequest), count > 0 {
                print("We already have data in Core Data")
                return
            }

            for champ in wildriftData {
                let newChampion = CDChampion(context: context)
                newChampion.name = champ.name
                newChampion.position = champ.position
                newChampion.ultimate = champ.ultimate
                newChampion.role = champ.role
                newChampion.image = champ.image
                newChampion.url = champ.url
                newChampion.gallery = champ.gallery.joined(separator: ",")
            }
            
            do {
                try context.save()
                print("Champions was uploaded in Core Data.")
            } catch {
                print("Error to save in Core Data: \(error)")
            }
    }

}
