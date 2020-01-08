//
//  AmiiboDetailViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/4/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboDetailViewController: UIViewController {

    @IBOutlet weak var amiiboImageView: UIImageView!
    @IBOutlet weak var amiiboNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var gameSeriesLabel: UILabel!
    @IBOutlet weak var amiiboSeriesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var backgroundNameLabel: UILabel!
    @IBOutlet weak var backgroundNameLabel2: UILabel!
    
    var amiibo: AmiiboElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundNameLabel2.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        backgroundNameLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        backgroundNameLabel.isHidden = true
        backgroundNameLabel.isHidden = true
        loadAmiibo()
    }
    func loadAmiibo() {
        amiiboNameLabel.text = amiibo?.name.uppercased()
        characterNameLabel.text = amiibo?.character
        gameSeriesLabel.text = amiibo?.gameSeries
        amiiboSeriesLabel.text = amiibo?.amiiboSeries
        backgroundNameLabel.text = amiibo?.character.uppercased()
        backgroundNameLabel2.text = amiibo?.character.uppercased()
        releaseDateLabel.text = amiibo?.release.na?.description
        amiiboImageView.getImage(with: amiibo?.image ?? "") { [weak self] (results) in
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
    @IBAction func viewButtonPressed() {
        if viewButton.backgroundColor == .black {
            viewButton.backgroundColor = .clear
            amiiboNameLabel.isHidden = true
            characterNameLabel.isHidden = true
            gameSeriesLabel.isHidden = true
            amiiboSeriesLabel.isHidden = true
            releaseDateLabel.isHidden = true
           // backgroundNameLabel.isHidden = false
           // backgroundNameLabel2.isHidden = false
        } else {
            viewButton.backgroundColor = .black
            amiiboNameLabel.isHidden = false
            characterNameLabel.isHidden = false
            gameSeriesLabel.isHidden = false
            amiiboSeriesLabel.isHidden = false
            releaseDateLabel.isHidden = false
            //backgroundNameLabel.isHidden = true
            //backgroundNameLabel2.isHidden = true
        }
    }
}
