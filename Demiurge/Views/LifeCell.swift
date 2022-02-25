//
//  LifeCell.swift
//  Demiurge
//
//  Created by Менетиос on 25.02.2022.
//

import UIKit

class LifeCell: UITableViewCell {

   
    @IBOutlet var gradientView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.clipsToBounds = true
        gradientView.clipsToBounds = true
        gradientView.backgroundColor = UIColor.clear
    
        gradientView.layer.cornerRadius = gradientView.frame.height / 2
        
    }

    func setUpImage(_ image: UIImage) {
        let layer = CALayer()
        layer.frame = gradientView.frame.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        layer.contents = image.cgImage
        gradientView.layer.addSublayer(layer)
       
    }
    
    func setUpGradient(with colors: [CGColor]) {
        let layer = CAGradientLayer()
        layer.frame = gradientView.bounds
        layer.colors = colors
        gradientView.layer.addSublayer(layer)
    }
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
