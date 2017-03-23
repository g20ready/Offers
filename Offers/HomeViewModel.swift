//
//  HomeViewModel.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {

    static let shared = HomeViewModel()
    
    var dailyOffersFetchedCompletion:(([Offer]) -> Void)?
    var dailyOffers = [Offer]() {
        didSet {
            if let completion = dailyOffersFetchedCompletion {
                completion(dailyOffers)
            }
        }
    }
    
    var interestingOffersFetchedCompletion:(([Offer]) -> Void)?
    var interestingOffers = [Offer]() {
        didSet {
            if let completion = interestingOffersFetchedCompletion {
                completion(interestingOffers)
            }
        }
    }
    
    var moreOffersFetchedCompletion:(([Offer]?) -> Void)?
    var moreOffers = [Offer]() {
        didSet {
            if let completion = moreOffersFetchedCompletion {
                completion(moreOffers)
            }
        }
    }
    
    var selectedOffer: Offer?
    
    
    
    func loadOffers() {
        NetworkManager.shared.fetchDailyOffers { [unowned self] (offers, error) in
            if let error = error {
                print("error while fetching daily offers : \(error.localizedDescription)")
                return;
            }
            self.dailyOffers = offers!
        }
        
        NetworkManager.shared.fetchInterestingOffers { [unowned self] (offers, error) in
            if let error = error {
                print("error while fetching interesting offers : \(error.localizedDescription)")
                return;
            }
            self.interestingOffers = offers!
        }
        
        NetworkManager.shared.fetchMoreOffers { [unowned self] (offers, error) in
            if let error = error {
                print("error while fetching more offers : \(error.localizedDescription)")
                return;
            }
            self.moreOffers = offers!
        }
    }
    
    
}
