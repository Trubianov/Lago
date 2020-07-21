//
//  StorageManager.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation

typealias FeedStorageUpdateCompletion<DataType> = ([DataType]) -> ()

protocol FeedsStorageProtocol: class {
    var lifeStyleModels: [LifeStyle] { get }
    var RSSWSJDModels: [RSSWSJD] { get }
    var worldNewsModels: [WorldNews] { get }
    
    func setupLifeStyleModels(lifeStyleModels: [LifeStyle])
    func setupRSSWSJDModels(RSSWSJDModels: [RSSWSJD])
    func setupWorldNewsModels(worldNewsModels: [WorldNews])
    
    var lifeStyleModelsUpdated: FeedStorageUpdateCompletion<LifeStyle>? { get set }
    var RSSWSJDModelsUpdated: FeedStorageUpdateCompletion<RSSWSJD>? { get set }
    var worldNewsModelsUpdated: FeedStorageUpdateCompletion<WorldNews>? { get set }
}

class FeedsStorageManager: FeedsStorageProtocol {
    
    var RSSWSJDModelsUpdated: FeedStorageUpdateCompletion<RSSWSJD>?
    var worldNewsModelsUpdated: FeedStorageUpdateCompletion<WorldNews>?
    var lifeStyleModelsUpdated: FeedStorageUpdateCompletion<LifeStyle>?
    
    private(set) var lifeStyleModels = [LifeStyle]()
    private(set) var RSSWSJDModels = [RSSWSJD]()
    private(set) var worldNewsModels = [WorldNews]()
    
    func setupLifeStyleModels(lifeStyleModels: [LifeStyle]) {
        DispatchQueue.main.async {
            self.lifeStyleModels = lifeStyleModels
        }
    }
    
    func setupRSSWSJDModels(RSSWSJDModels: [RSSWSJD]) {
        DispatchQueue.main.async {
            self.RSSWSJDModels = RSSWSJDModels
        }
    }
    
    func setupWorldNewsModels(worldNewsModels: [WorldNews]) {
        DispatchQueue.main.async {
            self.worldNewsModels = worldNewsModels
        }
    }
}
