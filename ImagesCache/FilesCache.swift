//
//  FilesCache.swift
//  ImagesCache
//
//  Created by Matias Gualino on 18/10/18.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func getImage(url: String, completion: @escaping ((UIImage?) -> Void))
}

class FilesCache {
    
    static var shared = FilesCache()
    
    var serviceProtocol: ImageServiceProtocol?
    
    fileprivate let diskPaths = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
    
    fileprivate let imagesDir = "cachedImages"
    fileprivate let memoryCache = NSCache<AnyObject, AnyObject>()
    
    fileprivate func getDiskPath(_ imageUrl: String) -> URL? {
        guard let cacheDirectory = self.diskPaths.first else {
            return nil
        }
        
        return cacheDirectory.appendingPathComponent("\(self.imagesDir)\(imageUrl.hashValue)")
    }
    
    func getImage(imageUrl: String, completion: @escaping ((UIImage?) -> Void)) {
        if let imageFromCache = self.memoryCache.object(forKey: imageUrl as AnyObject) as? UIImage {
            completion(imageFromCache)
        }
        
        if let diskPath = self.getDiskPath(imageUrl) {
            if FileManager.default.fileExists(atPath: diskPath.path), let image = UIImage(contentsOfFile: diskPath.path) {
                completion(image)
            } else {
                self.getImageFromServer(imageUrl, diskPath: diskPath, completion: completion)
            }
        } else {
            self.getImageFromServer(imageUrl, completion: completion)
        }
    }
    
    fileprivate func getImageFromServer(_ imageUrl: String, diskPath: URL? = nil, completion: @escaping ((UIImage?) -> Void)) {
        self.serviceProtocol?.getImage(url: imageUrl, completion: { image in
            guard let image = image else {
                completion(nil)
                return
            }
            
            self.memoryCache.setObject(image, forKey: imageUrl as AnyObject)
            if let path = diskPath, let data = UIImagePNGRepresentation(image) {
                try? data.write(to: path, options: Data.WritingOptions.atomic)
            }
            completion(image)
        })
    }
}
