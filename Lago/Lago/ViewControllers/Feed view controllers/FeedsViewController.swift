//
//  SecondViewController.swift
//  Lago
//
//  Created by Anton on 7/19/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit

protocol TitleSelectionDelegate {
    var delegate: InfoUpdateTitleProtocol { get set }
}

class FeedsViewController: UIViewController {
    
    enum SegmentType: Int {
        case businessNews = 0
        case entertainmentAndEnvironment = 1
    }

    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var businessNewsViewContainer: UIView!
    @IBOutlet weak var EntertainmentAndEnvironmentViewContainer: UIView!
    
    var currentDelegate: TitleSelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    @IBAction func segmentedControllValueChanged(_ sender: UISegmentedControl) {
        guard let selectedSegment = SegmentType(rawValue: sender.selectedSegmentIndex) else { return }
        self.updateSelectedSegment(segment: selectedSegment)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
            //currentDelegate =  businessNews View controller
            businessNewsViewContainer.isHidden = false
            EntertainmentAndEnvironmentViewContainer.isHidden = true
        case .entertainmentAndEnvironment:
            //currentDelegate = EntertainmentAndEnvironment View Controller
            businessNewsViewContainer.isHidden = true
            EntertainmentAndEnvironmentViewContainer.isHidden = false
        }
    }
}

