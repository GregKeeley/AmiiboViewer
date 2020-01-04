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
            }
        }
    }
}

extension AmiiboCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        amiibos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "amiiboCollectionCell", for: indexPath) as? AmiiboCollectionViewCell
        cell!.congifureCell(for: amiibos[indexPath.row])
        return cell!
    }
    
    
}
extension AmiiboCollectionViewController: UICollectionViewDelegate {
    
}
