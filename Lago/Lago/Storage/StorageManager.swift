//
//  StorageManager.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation

protocol FeedsStorageProtocol {
    var lifeStyleModels: [LifeStyle] { get }
    var RSSWSJDModels: [RSSWSJD] { get }
    var worldNewsModels: [WorldNews] { get }
}

class FeedsStorageManager: FeedsStorageProtocol {
    var lifeStyleModels = [LifeStyle]()
    var RSSWSJDModels = [RSSWSJD]()
    var worldNewsModels = [WorldNews]()
}
