//
//  HeaderOffersCollectionReusableView.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit

class HeaderOffersCollectionReusableView: UICollectionReusableView {
    
    var interestingOffers = [Offer]()
    var dailyOffers = [Offer]()
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var highlightsCollectionView: UICollectionView!
    @IBOutlet weak var headerPageControl: UIPageControl!
    
    let dailyOffersCollectionViewSource = DailyOffersCollectionViewSource()
    let interestingOffersCollectionViewSource = InterestingOffersCollectionViewSource()
    
    var offerSelected: ((Offer) -> Void)? {
        didSet {
            dailyOffersCollectionViewSource.offerSelected = offerSelected
            interestingOffersCollectionViewSource.offerSelected = offerSelected
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupHeaderCollectionView()
        self.setupHighlightsCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.headerCollectionView.reloadData()
        self.highlightsCollectionView.reloadData()
    }
    
    //MARK:- Setup
    
    func setupHeaderCollectionView() {
        headerCollectionView.dataSource = self.dailyOffersCollectionViewSource
        headerCollectionView.delegate = self.dailyOffersCollectionViewSource
    }
    
    func setupHighlightsCollectionView() {
        highlightsCollectionView.dataSource = self.interestingOffersCollectionViewSource
        highlightsCollectionView.delegate = self.interestingOffersCollectionViewSource
    }
    
}
