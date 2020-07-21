//
//  LifeStyelTableViewDataSource.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit

class LifeStyelTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var lifeStyleItems = [LifeStyle]()
    
    func setup(lifeStyleItems: [LifeStyle]) {
        self.lifeStyleItems = lifeStyleItems
    }
    
    //Mark: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeStyleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
