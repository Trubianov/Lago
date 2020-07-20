//
//  NetworkManager.swift
//  Lago
//
//  Created by Anton on 7/19/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let baseURL = URL(string: "https://feeds.a.dj.com/rss")
    
    
    static func downloadLifeStyleFeed() {
        guard let url = baseURL else { return }
        let lifeStyleURL = url.appendingPathComponent("RSSLifestyle.xml", isDirectory: false)
        let task = URLSession.shared.dataTask(with: lifeStyleURL) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed download RSSLifestyle xml: \(String(describing: error))")
                return
            }

            let parser = XMLParser(data: data)
            let lifeStyleXMLParser = LifeStyleRSSXMLDelegate()
            parser.delegate = lifeStyleXMLParser
            if parser.parse() {
                print("Success parsed life style feed")
            } else {
                print("Failed parse life style feed")
            }
        }
        task.resume()
    }
    
    func downloadRSSWSJD() {
        
    }
    
    func downloadRSSWorldNews() {
        
    }
}
