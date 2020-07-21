//
//  LifeStyleViewController.swift
//  Lago
//
//  Created by Anton on 7/20/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit

class LifeStyleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = LifeStyelTableViewDataSource()
    private var selectedLifeStyleItem: LifeStyle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        self.setupDataSource()
    }
    
    private func setupDataSource() {
        if let items = self.storage?.lifeStyleModels {
            dataSource.setup(lifeStyleItems: items)
        }
        
        self.storage?.lifeStyleModelsUpdated = { [weak self] lifeStyleModels in
            self?.dataSource.setup(lifeStyleItems: lifeStyleModels)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LifeStyleDetails",
            let lifeStyleDetailedController = segue.destination as? LifeStyleDetailedViewController {
            lifeStyleDetailedController.lifeStyle = self.selectedLifeStyleItem
        }
    }
}

extension LifeStyleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedLifeStyleItem = dataSource.lifeStyleItems[indexPath.row]
        return indexPath
    }
}
