//
//  ImageLoader.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/20/23.
//

import UIKit

import UIKit


class ImageLoader {
    static let shared = ImageLoader()

    private let imageCache = NSCache<NSString, UIImage>()
    private let placeholderImage = UIImage(named: "spacex") 
    private init() {}

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            completion(placeholderImage) // Return the placeholder image initially

            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self,
                      error == nil,
                      let data = data,
                      let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }

                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }.resume()
        }
    }
}
