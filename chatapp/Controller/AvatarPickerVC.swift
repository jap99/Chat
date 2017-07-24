//
//  AvatarPickerVC.swift
//  chatapp
//
//  Created by Javid Poornasir on 7/20/17.
//  Copyright © 2017 Javid Poornasir. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var sc: UISegmentedControl!
    
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cv.delegate = self
        cv.dataSource = self
        
    }
    
    // MARK: - Collection View Delegates
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        
        return AvatarCell() 
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // make sizes of cells and columns dynamic; contingent upon device used
        
        var numbOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 { // iphone SE
            numbOfColumns = 4
        }
        
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = ((cv.bounds.width - padding) - (numbOfColumns - 1) * spaceBetweenCells) / numbOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func scChanged(_ sender: Any) {
        
        if sc.selectedSegmentIndex == 0 {
            
            avatarType = .dark
        } else {
            
            avatarType = .light
        }
        
        cv.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
