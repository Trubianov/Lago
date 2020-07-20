//
//  SecondViewController.swift
//  Lago
//
//  Created by Anton on 7/19/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {
    
    enum SegmentType: Int {
        case businessNews = 0
        case entertainmentAndEnvironment = 1
    }

    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var businessNewsViewContainer: UIView!
    @IBOutlet weak var EntertainmentAndEnvironmentViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    @IBAction func segmentedControllValueChanged(_ sender: UISegmentedControl) {
        guard let selectedSegment = SegmentType(rawValue: sender.selectedSegmentIndex) else { return }
        self.updateSelectedSegment(segment: selectedSegment)
    }
}

private extension FeedsViewController {
    
    private func setupUI() {
        guard let selectedSegment = SegmentType(rawValue: segmentedControll.selectedSegmentIndex) else { return }
        self.updateSelectedSegment(segment: selectedSegment)
    }
    
    private func updateSelectedSegment(segment: SegmentType) {
        switch segment {
        case .businessNews:
            businessNewsViewContainer.isHidden = false
            EntertainmentAndEnvironmentViewContainer.isHidden = true
        case .entertainmentAndEnvironment:
            businessNewsViewContainer.isHidden = true
            EntertainmentAndEnvironmentViewContainer.isHidden = false
        }
    }
}

