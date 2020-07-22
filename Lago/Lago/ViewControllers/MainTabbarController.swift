//
//  MainTabbarController.swift
//  Lago
//
//  Created by Anton on 7/22/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation
import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let infoViewController = self.viewControllers?[0] as? InfoViewController else { return }
        guard let feedsViewController = self.viewControllers?[0] as? FeedsViewController else { return }
            
        
    }
}
