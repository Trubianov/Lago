//
//  RSSWSJDXMLDelegate.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation

class RSSWSJDXMLDelegate: NSObject, XMLParserDelegate {
    
    var RSSWSJDItems = [RSSWSJD]()
    var elementName: String?
    var title: String?
    var link: String?
    var itemDescription: String?
    var pubDate: Date?
    var articletype: String?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "item" {
            title = nil
            link = nil
            itemDescription = nil
            pubDate = nil
        }

        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {
                title = data
            } else if self.elementName == "link" {
                link = data
            } else if self.elementName == "description" {
                itemDescription = data
            } else if self.elementName == "pubDate" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
                pubDate = dateFormatter.date(from: data)
            } else if self.elementName == "wsj:articletype" {
                articletype = data
            }
        }
    }

    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssWSJD = RSSWSJD(title: title, link: link, description: itemDescription, pubDate: pubDate, articletype: articletype)
            RSSWSJDItems.append(rssWSJD)
        }
    }
}
