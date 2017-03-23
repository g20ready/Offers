//
//  HeaderOffersCollectionViewSource.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit
import Nuke

class DailyOffersCollectionViewSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var offers : [Offer] {
        get {
            return HomeViewModel.shared.dailyOffers
        }
    }
    
    var offerSelected: ((Offer) -> Void)?
    
    //MARK:- UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath) as! DailyOfferCollectionViewCell
        let offer = offers[indexPath.row]
        cell.titleLabel.text = offer.title
        cell.companyLabel.text = offer.company
        cell.imageView.image = nil
        if let imageUrl = offer.image {
            Nuke.loadImage(with: URL(string: imageUrl)!, into: cell.imageView)
        }
        return cell
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    //MARK:- UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let offerSelected = offerSelected {
            let offer = self.offers[indexPath.row]
            offerSelected(offer)
        }
    }
}
