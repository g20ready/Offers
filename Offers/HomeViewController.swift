//
//  ViewController.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    let offersCollectionViewSource = SimpleOffersCollectionViewSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        HomeViewController.setNavigationBarColor(navigationController: self.navigationController,
                                             color: UIColor.clear)
        
        self.setupHomeViewModel()
        self.setupOffersCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    class func setNavigationBarColor(navigationController : UINavigationController?,
                                     color : UIColor) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = color
        navigationController?.navigationBar.backgroundColor =  color
    }

    //MARK:- Setup
    
    func setupHomeViewModel() {
        HomeViewModel.shared.dailyOffersFetchedCompletion = { [unowned self] offers in
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        HomeViewModel.shared.interestingOffersFetchedCompletion = { [unowned self] offers in
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        HomeViewModel.shared.moreOffersFetchedCompletion = { [unowned self] offers in
            self.collectionView.reloadSections(IndexSet(integer: 1))
        }
        
        HomeViewModel.shared.loadOffers()
    }
    
    func setupOffersCollectionView() {
        self.offersCollectionViewSource.offerSelected = { offer in
            HomeViewModel.shared.selectedOffer = offer
            self.performSegue(withIdentifier: "offerDetailSegue", sender: nil)
        }
        self.collectionView.dataSource = self.offersCollectionViewSource
        self.collectionView.delegate = self.offersCollectionViewSource
    }
}

