//
//  NetworkManager.swift
//  Lago
//
//  Created by Anton on 7/19/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation

private typealias DownloadCompletion = () -> ()

class NetworkManager {
    
    static let baseURL = URL(string: "https://feeds.a.dj.com/rss")
    static let lifeStyleFeed = "RSSLifestyle.xml"
    static let WSJDFeed = "RSSWSJD.xml"
    static let worldNewsFeed = "RSSWorldNews.xml"
    static let updateTimeSeconds = 5
    static let  timer = DispatchSource.makeTimerSource()
    
    static func startUpdateFeeds( feedsStorage: FeedsStorageManager) {
        timer.schedule(deadline: .now(), repeating: .seconds(updateTimeSeconds))
        timer.setEventHandler(handler: {
            downloadFeeds(feedsStorage: feedsStorage)
        })
        timer.resume()
    }
    
    static func stopUpdateFeeds() {
        timer.setEventHandler(handler: nil)
        timer.cancel()
    }
    
    private static func downloadFeeds(feedsStorage: FeedsStorageManager) {
        self.downloadLifeStyleFeed(feedsStorage: feedsStorage, completion: nil)
        self.downloadWorldNewsAndWSJD(feedsStorage: feedsStorage)
    }
    
    private static func downloadWorldNewsAndWSJD(feedsStorage: FeedsStorageManager) {
        let downloadGroup = DispatchGroup()
        
        downloadGroup.enter()
        self.downloadRSSWorldNews(feedsStorage: feedsStorage) {
            downloadGroup.leave()
        }
        
        downloadGroup.enter()
        self.downloadRSSWSJD(feedsStorage: feedsStorage) {
            downloadGroup.leave()
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
            print("Downloaded both")
            feedsStorage.setupWorldNewsAndWSJDUpdated()
        }
    }
    
    private static func downloadLifeStyleFeed(feedsStorage: FeedsStorageManager, completion: DownloadCompletion?) {
        guard let url = baseURL else {
            print("Failed download \(lifeStyleFeed))")
            (completion ?? {})()
            return
        }
        let lifeStyleURL = url.appendingPathComponent(lifeStyleFeed, isDirectory: false)
        let task = URLSession.shared.dataTask(with: lifeStyleURL) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed download \(lifeStyleFeed): \(String(describing: error))")
                (completion ?? {})()
                return
            }

            let parser = XMLParser(data: data)
            let lifeStyleXMLParser = LifeStyleRSSXMLDelegate()
            parser.delegate = lifeStyleXMLParser
            if parser.parse() {
                print("Success parsed life style feed")
                feedsStorage.setupLifeStyleModels(lifeStyleModels: lifeStyleXMLParser.lifeStyleItems)
            } else {
                print("Failed parse life style feed")
            }
            (completion ?? {})()
        }
        task.resume()
    }
    
    private static func downloadRSSWSJD(feedsStorage: FeedsStorageManager, completion: DownloadCompletion?) {
        guard let url = baseURL else {
            print("Failed download \(WSJDFeed))")
            (completion ?? {})()
            return
        }
        let WSJD_URL = url.appendingPathComponent(WSJDFeed, isDirectory: false)
        let task = URLSession.shared.dataTask(with: WSJD_URL) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed download \(WSJDFeed): \(String(describing: error))")
                (completion ?? {})()
                return
            }

            let parser = XMLParser(data: data)
            let RSSWSJDXMLParser = RSSWSJDXMLDelegate()
            parser.delegate = RSSWSJDXMLParser
            if parser.parse() {
                print("Success parsed RSS WSJD feed")
                feedsStorage.setupRSSWSJDModels(RSSWSJDModels: RSSWSJDXMLParser.RSSWSJDItems)
            } else {
                print("Failed parse RSS WSJD feed")
            }
            (completion ?? {})()
        }
        task.resume()
    }
    
    private static func downloadRSSWorldNews(feedsStorage: FeedsStorageManager, completion: DownloadCompletion?) {
        guard let url = baseURL else {
            print("Failed download \(worldNewsFeed))")
            (completion ?? {})()
            return
        }
        let worldNewURL = url.appendingPathComponent(worldNewsFeed, isDirectory: false)
        let task = URLSession.shared.dataTask(with: worldNewURL) { data, response, error in
            guard let data = data, error == nil else {
                (completion ?? {})()
                print("Failed download \(worldNewsFeed): \(String(describing: error))")
                return
            }

            let parser = XMLParser(data: data)
            let worldNewsXMLParser = WorldNewXMLDelegate()
            parser.delegate = worldNewsXMLParser
            if parser.parse() {
                print("Success parsed \(worldNewsFeed)")
                feedsStorage.setupWorldNewsModels(worldNewsModels: worldNewsXMLParser.WorldNewsItems)
            } else {
                print("Failed parse \(worldNewsFeed)")
            }
            (completion ?? {})()
        }
        task.resume()
    }
}
