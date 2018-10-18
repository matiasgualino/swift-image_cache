//
//  ImageService.swift
//  ImagesCache
//
//  Created by Matias Gualino on 18/10/18.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

class ImageService: ImageServiceProtocol {
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func getImage(url: String, completion: @escaping ((UIImage?) -> Void)) {
        guard let URL = URL(string: url) else {
            completion(nil)
            return
        }
        
        self.getDataFromUrl(url: URL) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
}
