//
//  AmiiboCollectionViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/4/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboCollectionViewController: UIViewController {

    @IBOutlet weak var amiiboCollectionView: UICollectionView!
    
    var sortMethod = 0
    var amiibos = [AmiiboElement]() {
        didSet {
            DispatchQueue.main.async {
                self.amiiboCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amiiboCollectionView.dataSource = self
        amiiboCollectionView.delegate = self
        loadAmiibos()
        
    }


    func loadAmiibos() {
        AmiiboAPI.getAllAmiibos { [weak self] result in
            switch result {
            case .failure(let appError):
                print("Failed to load: \(appError)")
            case .success(let data):
                
                self?.amiibos = data
                print("Count from viewDidLoad: \(self?.amiibos.count)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let amiiboDetailVC = segue.destination as? AmiiboDetailViewController,
                let indexPath = amiiboCollectionView.indexPathsForSelectedItems?.first else {
                    fatalError("Failed to prepare for Detail Segue")
            }
            amiiboDetailVC.amiibo = amiibos[indexPath.row]
        } else if segue.identifier == "favoriteSegue" {
            print("favoriteSegue")
            }
        }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        loadAmiibos()
    }
    
    func sortedAmiibos(amiibos: [AmiiboElement]) {
        
    }
}

extension AmiiboCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        amiibos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "amiiboCollectionCell", for: indexPath) as? AmiiboCollectionViewCell
        cell?.contentView.layer.cornerRadius = 8.0
        cell?.contentView.layer.borderWidth = 1.0
        cell!.congifureCell(for: amiibos[indexPath.row])
        return cell!
    }
    
   
}
extension AmiiboCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 150.0)
    }
}
extension AmiiboCollectionViewController: UICollectionViewDelegate {
}
