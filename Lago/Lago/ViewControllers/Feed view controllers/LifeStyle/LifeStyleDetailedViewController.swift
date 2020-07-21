//
//  LifeStyleDetailedViewController.swift
//  Lago
//
//  Created by Anton on 7/21/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import Foundation
import UIKit

class LifeStyleDetailedViewController: UIViewController {
    var lifeStyle: LifeStyle?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        guard let lifeStyle = self.lifeStyle else { return }
        
        if let date = lifeStyle.pubDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm E, d MMM y"
            dateLabel.text = formatter.string(from: date)
        }
        
        self.titleLabel.text = lifeStyle.title
        self.descrLabel.text = lifeStyle.description
        self.linkLabel.text = lifeStyle.link
    }
    
    @IBAction func openLinkAction(_ sender: UITapGestureRecognizer) {
        guard  let url = URL(string: self.lifeStyle?.link ?? "") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
