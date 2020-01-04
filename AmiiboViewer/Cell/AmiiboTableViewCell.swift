//
//  AmiiboTableViewCell.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/3/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amiiboNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var amiiboImageView: UIImageView!
    
    func configureCell(amiibo: AmiiboElement) {
        amiiboNameLabel.text = amiibo.name
        releaseDateLabel.text = amiibo.release.na
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
