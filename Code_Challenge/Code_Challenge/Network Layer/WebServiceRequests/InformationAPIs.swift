//
//  InformationAPIs.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

enum InfoRequests {
    case getAllInformations
}

extension InfoRequests: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        case .getAllInformations:
            methodType = .get
        }
        return methodType
    }

    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        case .getAllInformations:
            apiEndPath = "/facts.json"
        }
        return apiEndPath
    }

    func apiBasePath() -> String {
        switch self {
        case .getAllInformations :
            return WebserviceConstants.baseURL
        }
    }
}
