//
//  OffersCollectionViewSource.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit
import Nuke

class SimpleOffersCollectionViewSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let space : CGFloat = 31.0
    
    var offers : [Offer] {
        get {
            return HomeViewModel.shared.moreOffers
        }
    }
    
    var offerSelected: ((Offer) -> Void)?
    
    //MARK:- UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return self.offers.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath) as! SimpleOfferCollectionViewCell
        let offer = self.offers[indexPath.row]
        cell.titleLabel.text = offer.title
        cell.subtitleLabel.text = offer.company
        if let price = offer.price {
            cell.priceLabel.text = "€ \(price)"
        }else {
            cell.priceLabel.text = "-"
        }
        cell.productImageView.image = nil
        if let imageUrl = offer.image {
            Nuke.loadImage(with: URL(string: imageUrl)!, into: cell.productImageView)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerOffersSupplementaryView", for: indexPath) as! HeaderOffersCollectionReusableView
        headerView.offerSelected = offerSelected
        return headerView
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - space/2, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: space/3, bottom: space/3, right: space/3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 438)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let offerSelected = offerSelected {
            let offer = self.offers[indexPath.row]
            offerSelected(offer)
        }
    }
    
}
