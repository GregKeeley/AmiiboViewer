//
//  AmiiboCollectionViewCell.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/4/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amiiboImageView: UIImageView!
    
    func congifureCell(for amiibo: AmiiboElement) {
        
        amiiboImageView.getImage(with: amiibo.image) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print("Failed to load image: \(appError)")
                DispatchQueue.main.async {
                    self?.amiiboImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.amiiboImageView.image = image
                }
            }
        }
    }
}
