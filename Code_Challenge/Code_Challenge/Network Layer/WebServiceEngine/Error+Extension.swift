//
//  Error+Extension.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

extension Error {
    
    public func title() -> String? {
        return nil
    }
    
    public func message() -> String? {
        var message: String?
        
        let error = self as NSError
        let errormessage  = error.userInfo["message"] as? String
        let code = error.code
        
        switch code {
        case -1009:
            message = "No Internet connection. Please check your internet connection."
            break
        case -1001:
            message = "Your network connection seems to be slow. Please check your network connection."
            break
        case -1003:
            message = "Cannot connect to server. Please try later."
            break
        case 500:
            message = "Cannot connect to server."
            break
        default:
            message = "Error in connection. Please check your internet connection and try again."
            if errormessage != nil {
                message = errormessage
            }
        }
        return message
    }
    
}
