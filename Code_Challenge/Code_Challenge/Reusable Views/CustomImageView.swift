//
//  CustomImageView.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {

    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString

        guard let url = URL(string: urlString) else { return }

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, respones, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let imageData = data,
                let self = self else {
                    return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: imageData) {
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }

        }).resume()
    }

}
