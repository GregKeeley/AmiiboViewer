//
//  SortByViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SortByViewController: UIViewController {

//    @IBOutlet var sortButtons: [UIButton]!
    
     var setFilterMethod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        setFilterMethod = sender.tag
        print("sortButton: \(setFilterMethod)")
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let collectionVC = segue.destination as? AmiiboCollectionViewController else {
            fatalError("Failed to prepare for segue to CollectionViewController")
        }
        print("unwind: \(setFilterMethod)")
        let filter = setFilterMethod
        print(filter)
        collectionVC.filterMethod = filter
    
    }
    
}
