//
//  StorageManager.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation

typealias FeedStorageLifeStyleUpdateCompletion = ([LifeStyle]) -> ()
typealias FeedStorageWorldNewsAndWSJDUpdatedCompletion = ([WorldNews], [RSSWSJD]) -> ()

protocol FeedsStorageProtocol: class {
    var lifeStyleModels: [LifeStyle] { get }
    var RSSWSJDModels: [RSSWSJD] { get }
    var worldNewsModels: [WorldNews] { get }
    
    func setupLifeStyleModels(lifeStyleModels: [LifeStyle])
    func setupRSSWSJDModels(RSSWSJDModels: [RSSWSJD])
    func setupWorldNewsModels(worldNewsModels: [WorldNews])
    func setupWorldNewsAndWSJDUpdated()
    
    var lifeStyleModelsUpdated:FeedStorageLifeStyleUpdateCompletion? { get set }
    var worldNewsAndWSJDUpdated: FeedStorageWorldNewsAndWSJDUpdatedCompletion? { get set }
}

class FeedsStorageManager: FeedsStorageProtocol {
    
    var lifeStyleModelsUpdated: FeedStorageLifeStyleUpdateCompletion?
    var worldNewsAndWSJDUpdated: FeedStorageWorldNewsAndWSJDUpdatedCompletion?
    
    private(set) var lifeStyleModels = [LifeStyle]()
    private(set) var RSSWSJDModels = [RSSWSJD]()
    private(set) var worldNewsModels = [WorldNews]()
    
    func setupLifeStyleModels(lifeStyleModels: [LifeStyle]) {
        DispatchQueue.main.async {
            self.lifeStyleModels = lifeStyleModels
            if let updateAction = self.lifeStyleModelsUpdated {
                updateAction(lifeStyleModels)
            }
        }
    }
    
    func setupRSSWSJDModels(RSSWSJDModels: [RSSWSJD]) {
        self.RSSWSJDModels = RSSWSJDModels
    }
    
    func setupWorldNewsModels(worldNewsModels: [WorldNews]) {
        self.worldNewsModels = worldNewsModels
    }
    
    func setupWorldNewsAndWSJDUpdated() {
        if let updateAction = self.worldNewsAndWSJDUpdated {
            updateAction(self.worldNewsModels, self.RSSWSJDModels)
        }
    }
}
