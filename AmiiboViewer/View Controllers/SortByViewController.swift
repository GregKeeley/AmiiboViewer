//
//  SortByViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SortByViewController: UIViewController {

    @IBOutlet var sortButtons: [UIButton]!
    
     var setSortMethod = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        setSortMethod = sender.tag
        }
       // dismiss(animated: true)
//    }
    @IBAction func unwindToCollection(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? AmiiboCollectionViewController
        sourceViewController?.sortMethod = setSortMethod
        sourceViewController?.loadAmiibos()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let collectionVC = segue.destination as? AmiiboCollectionViewController else {
            fatalError("Failed to prepare for segue to CollectionViewController")
        }
        let sortMethod = setSortMethod
        collectionVC.sortMethod = sortMethod
    }
    
}
