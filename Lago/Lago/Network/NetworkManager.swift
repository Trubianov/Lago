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
    static let lifeStyleFeed = "RSSLifestyle.xml"
    static let WSJDFeed = "RSSWSJD.xml"
    static let worldNewsFeed = "RSSWorldNews.xml"
    
    static func downloadFeeds(feedsStorage: FeedsStorageManager) {
        self.downloadLifeStyleFeed(feedsStorage: feedsStorage)
        self.downloadRSSWorldNews(feedsStorage: feedsStorage)
        self.downloadRSSWSJD(feedsStorage: feedsStorage)
    }
    
    private static func downloadLifeStyleFeed(feedsStorage: FeedsStorageManager) {
        guard let url = baseURL else { return }
        let lifeStyleURL = url.appendingPathComponent(lifeStyleFeed, isDirectory: false)
        let task = URLSession.shared.dataTask(with: lifeStyleURL) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed download \(lifeStyleFeed): \(String(describing: error))")
                return
            }

            let parser = XMLParser(data: data)
            let lifeStyleXMLParser = LifeStyleRSSXMLDelegate()
            parser.delegate = lifeStyleXMLParser
            if parser.parse() {
                print("Success parsed life style feed")
                feedsStorage.lifeStyleModels = lifeStyleXMLParser.lifeStyleItems
            } else {
                print("Failed parse life style feed")
            }
        }
        task.resume()
    }
    
    private static func downloadRSSWSJD(feedsStorage: FeedsStorageManager) {
        guard let url = baseURL else { return }
        let WSJD_URL = url.appendingPathComponent(WSJDFeed, isDirectory: false)
        let task = URLSession.shared.dataTask(with: WSJD_URL) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed download \(WSJDFeed): \(String(describing: error))")
                return
            }

            let parser = XMLParser(data: data)
            let RSSWSJDXMLParser = RSSWSJDXMLDelegate()
            parser.delegate = RSSWSJDXMLParser
            if parser.parse() {
                print("Success parsed RSS WSJD feed")
                feedsStorage.RSSWSJDModels = RSSWSJDXMLParser.RSSWSJDItems
            } else {
                print("Failed parse RSS WSJD feed")
            }
        }
        task.resume()
    }
    
    private static func downloadRSSWorldNews(feedsStorage: FeedsStorageManager) {
        guard let url = baseURL else { return }
        let worldNewURL = url.appendingPathComponent(worldNewsFeed, isDirectory: false)
        let task = URLSession.shared.dataTask(with: worldNewURL) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed download \(worldNewsFeed): \(String(describing: error))")
                return
            }

            let parser = XMLParser(data: data)
            let worldNewsXMLParser = WorldNewXMLDelegate()
            parser.delegate = worldNewsXMLParser
            if parser.parse() {
                print("Success parsed \(worldNewsFeed)")
                feedsStorage.worldNewsModels = worldNewsXMLParser.WorldNewsItems
            } else {
                print("Failed parse \(worldNewsFeed)")
            }
        }
        task.resume()
    }
}
