//
//  WorldNewAndWSJD.swift
//  Lago
//
//  Created by Anton on 7/22/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation
import UIKit

class WorldNewAndWSJDViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
    }
    
    private func setupDataSource() {
        if let worldNews = self.storage?.worldNewsModels, let wjsd = self.storage?.RSSWSJDModels {
            //setup data source
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.storage?.worldNewsAndWSJDUpdated = { [weak self] news, wsjds in
            print("updated")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.storage?.worldNewsAndWSJDUpdated = nil
        super.viewWillDisappear(animated)
    }
}

