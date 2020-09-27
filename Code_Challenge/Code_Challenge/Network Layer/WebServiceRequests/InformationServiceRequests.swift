//
//  ContactServiceRequests.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

typealias GetAllInfoResponse = (Information?, _ error: Error?) -> Void

protocol InfoServiceRequestType {
    @discardableResult func getAllInformations(completion: @escaping GetAllInfoResponse) -> URLSessionDataTask?
}

struct InfoServiceRequests: InfoServiceRequestType {
    @discardableResult func getAllInformations(completion: @escaping GetAllInfoResponse) -> URLSessionDataTask? {
        let contactRequestModel = APIRequestModel(api: InfoRequests.getAllInformations)
        return WebserviceHelper.requestAPI(apiModel: contactRequestModel) { response in
            switch response {
            case .success(let serverData):
                guard let responseData = serverData else {
                    completion(nil, nil)
                    return
                }
                guard let string = String(data: responseData, encoding: String.Encoding.isoLatin1) else {
                    completion(nil, nil)
                    return }
                guard let properData = string.data(using: .utf8, allowLossyConversion: true) else {
                    completion(nil, nil)
                    return }
                JSONResponseDecoder.decodeFrom(properData, returningModelType: Information.self, completion: { (contactList, error) in
                    completion(contactList, error)
                })
                
            case .error(let error, _):
                completion(nil, error)
            }
        }
    }
}
