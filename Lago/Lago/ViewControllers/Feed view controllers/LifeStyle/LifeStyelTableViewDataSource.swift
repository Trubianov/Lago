//
//  LifeStyelTableViewDataSource.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit

class LifeStyelTableViewDataSource: NSObject, UITableViewDataSource {
    
    private(set) var lifeStyleItems = [LifeStyle]()
    
    func setup(lifeStyleItems: [LifeStyle]) {
        self.lifeStyleItems = lifeStyleItems
    }
    
    //Mark: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeStyleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleTableViewCell.reuseID, for: indexPath)
        if let lifeStyleCell = cell as? LifeStyleTableViewCell {
            let item = self.lifeStyleItems[indexPath.row]
            lifeStyleCell.setup(lifstyleItem: item)
        }
        return cell
    }
}
