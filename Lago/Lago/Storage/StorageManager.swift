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
}

class FeedsStorageManager: FeedsStorageProtocol {
    var lifeStyleModels = [LifeStyle]()
}
