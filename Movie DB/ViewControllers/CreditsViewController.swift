//
//  CreditsViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import UIKit


class CreditsViewController: UIViewController {
    
    let creditViewModel = CreditsViewModel()
    @IBOutlet weak var creditCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCollectionView.dataSource = self
        creditCollectionView.delegate = self
        
        creditCollectionView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        // register xib
        creditCollectionView.register(UINib(nibName: CreditsCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CreditsCollectionViewCell.reuseIdentifier)
        
        creditViewModel.bind { state in
            switch state {
            case .initial:
                break
            case .loading:
                print("Loading...")
            case .loaded:
             self.creditCollectionView.reloadData()
            case .error(let error):
                print("Error: \(error)")
            }
        }
        creditViewModel.loadCredits()
    }
}

extension CreditsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creditViewModel.credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = creditCollectionView.dequeueReusableCell(withReuseIdentifier: CreditsCollectionViewCell.reuseIdentifier, for: indexPath) as! CreditsCollectionViewCell
        
        let getcreditCellData = creditViewModel.fetchcellData(at: indexPath)
        
        let profilePath = getcreditCellData.profilePath
        cell.nameLabel.text = getcreditCellData.nameLabel
        cell.subNameLabel.text = getcreditCellData.subNameLabel
        creditViewModel.loadImage(at: profilePath) { image in
            cell.uiImageView.image = image
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CreditCollectionViewHeader", for: indexPath)
        return header
        
    }
    
}

extension CreditsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 160)
    }
}
