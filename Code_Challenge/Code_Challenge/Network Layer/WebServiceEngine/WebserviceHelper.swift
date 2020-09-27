//
//  WebserviceHelper.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

enum APIResponse {
    case success(Data?)
    case error(Error?, Data?)
}

typealias WebServiceCompletionBlock = (_ response: APIResponse) -> Void

/// Helper class to prepare request(adding headers & clubbing base URL) & perform API request.
struct WebserviceHelper {
    
    /// Performs a API request which is called by any service request class.
    /// It also performs an additional task of validating the auth token and refreshing if necessary
    ///
    /// - Parameters:
    ///   - apiModel: APIModelType which contains the info about api endpath, header & http method type.
    ///   - completion: Request completion handler.
    /// - Returns: Returns a URLSessionDataTask instance.
    @discardableResult public static func requestAPI(apiModel: APIModelType, completion: @escaping WebServiceCompletionBlock) -> URLSessionDataTask? {
        let escapedAddress = (apiModel.api.apiBasePath()+apiModel.api.apiEndPath()).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        request.httpMethod = apiModel.api.httpMthodType().rawValue
        request.allHTTPHeaderFields = WebserviceConfig().generateHeader()

        if let params = apiModel.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        print(request)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }

            if let httpStatus = response as? HTTPURLResponse,  ![200, 201].contains(httpStatus.statusCode) {
                completion(APIResponse.error(nil, data))
            }
            completion(APIResponse.success(data))

        }
        task.resume()
        return task
    }

}
