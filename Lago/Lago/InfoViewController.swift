//
//  FirstViewController.swift
//  Lago
//
//  Created by Anton on 7/19/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    let timer = DispatchSource.makeTimerSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTimerUpdate()
    }

    private func setupTimerUpdate() {
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler(handler: { [weak self] in
            DispatchQueue.main.async {
                let currentDate = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss E, d MMM y"
                self?.timeLabel.text = formatter.string(from: currentDate)
            }
        })
        timer.resume()
    }
    
    deinit {
        timer.setEventHandler(handler: nil)
        timer.cancel()
    }
}

