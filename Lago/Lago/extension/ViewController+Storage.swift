//
//  ViewController+Storage.swift
//  Lago
//
//  Created by Anton on 7/21/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var storage: FeedsStorageProtocol? {
        get {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                return appDelegate.feedsStorage
            }
            return nil
        }
    }
}
