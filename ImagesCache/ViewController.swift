//
//  ViewController.swift
//  ImagesCache
//
//  Created by Matias Gualino on 18/10/18.
//  Copyright © 2018 Matias Gualino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2017/04/24/14930199061053.jpg"
        FilesCache.shared.serviceProtocol = ImageService()
        FilesCache.shared.getImage(imageUrl: imageURL, completion: { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

