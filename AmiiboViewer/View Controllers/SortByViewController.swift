//
//  SortByViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SortByViewController: UIViewController {
    
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var seriesButton: UIButton!
    @IBOutlet weak var alphaButton: UIButton!
    @IBOutlet weak var setSortButton: UIButton!
    @IBOutlet weak var arrowMarker1: UIButton!
    @IBOutlet weak var arrowMarker2: UIButton!
    
     var setFilterMethod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearButton.layer.cornerRadius = 8
        gameButton.layer.cornerRadius = 8
        seriesButton.layer.cornerRadius = 8
        alphaButton.layer.cornerRadius = 8
        setSortButton.layer.cornerRadius = 8
        setSortButton.isEnabled = false
        arrowMarker1.isHidden = true
        arrowMarker2.isHidden = true
        
    }
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        setFilterMethod = sender.tag
        setSortButton.isEnabled = true
        arrowMarker1.isHidden = false
        arrowMarker2.isHidden = false
        }
    @IBAction func setSortMethodPressed() {
    }
}
