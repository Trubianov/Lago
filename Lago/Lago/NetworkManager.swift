//
//  NetworkManager.swift
//  Lago
//
//  Created by Anton on 7/19/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation
<<<<<<< HEAD

class NetworkManager {
    
    let baseURL = URL(string: "https://feeds.a.dj.com/rss")
    
    func downloadLifeStyleFeed() {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                print(self.results ?? "No results")
            }
        }
        task.resume()
    }
    
    func downloadRSSWSJD() {
        
    }
    
    func downloadRSSWorldNews() {
        
    }
}
=======
>>>>>>> 79358ad602c6c1ecdbd0fdde575339d8bda8a738
