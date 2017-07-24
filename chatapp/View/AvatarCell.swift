//
//  AvatarCell.swift
//  chatapp
//
//  Created by Javid Poornasir on 7/20/17.
//  Copyright © 2017 Javid Poornasir. All rights reserved.
//

import UIKit

// to find out whether it's a dark or light cell
enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    // we need to know the index so we can set the image
    func configureCell(index: Int, type: AvatarType) {
        
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setupView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
}
