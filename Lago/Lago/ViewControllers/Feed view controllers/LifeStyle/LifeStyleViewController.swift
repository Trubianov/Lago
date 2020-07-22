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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
            self.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.storage?.lifeStyleModelsUpdated = { [weak self] lifeStyleModels in
            self?.dataSource.setup(lifeStyleItems: lifeStyleModels)
            self?.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.storage?.lifeStyleModelsUpdated = nil
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LifeStyleDetails",
            let lifeStyleDetailedController = segue.destination as? LifeStyleDetailedViewController {
            lifeStyleDetailedController.lifeStyle = self.selectedLifeStyleItem
        }
    }
    
    func reloadData() {
        self.activityIndicator.isHidden = false
        self.tableView.reloadData()
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
        }
    }
}

extension LifeStyleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedLifeStyleItem = dataSource.lifeStyleItems[indexPath.row]
        return indexPath
    }
}
