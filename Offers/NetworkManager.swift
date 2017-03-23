//
//  NetworkManager.swift
//  Offers
//
//  Created by Marsel Tzatzo on 23/03/2017.
//  Copyright © 2017 max. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class NetworkManager: NSObject {

    
    
    static let shared = NetworkManager()
    
    override init() { }
    
    enum Router : URLRequestConvertible {
        
        case dailyOffers
        case interestingOffers
        case moreOffers
        
        public func asURLRequest() throws -> URLRequest {
            switch self {
            case .dailyOffers:
                return URLRequest(url: URL(string: "https://s3-eu-west-1.amazonaws.com/offerista-challenge/1.json")!)
            case .interestingOffers:
                return URLRequest(url: URL(string: "https://s3-eu-west-1.amazonaws.com/offerista-challenge/2.json")!)
            case .moreOffers:
                return URLRequest(url: URL(string: "https://s3-eu-west-1.amazonaws.com/offerista-challenge/3.json")!)
            }
            
        }
    }
    
    
    func fetchDailyOffers(_ completion: @escaping ([Offer]?, Error?) -> Void) {
        Alamofire
            .request(Router.dailyOffers)
            .responseString { response in
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    func fetchInterestingOffers(_ completion: @escaping ([Offer]?, Error?) -> Void) {
        Alamofire
            .request(Router.interestingOffers)
            .responseString { response in
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    func fetchMoreOffers(_ completion: @escaping ([Offer]?, Error?) -> Void) {
        Alamofire
            .request(Router.moreOffers)
            .responseString { response in
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    fileprivate func handleResponse(response: DataResponse<String>, completion: ([Offer]?, Error?) -> Void) {
        switch response.result {
        case .success(let response):
            let offers = Mapper<Offer>().mapArray(JSONString: response)
            completion(offers, nil)
        case .failure(let error):
            completion(nil, error)
        }
    }
    
    
}
