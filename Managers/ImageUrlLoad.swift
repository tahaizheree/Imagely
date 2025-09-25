//
//  ImageUrlLoad.swift
//  Imagely
//
//  Created by Mateen on 9/24/25.
//

import UIKit

extension UIImageView {
    func load(index: Int,url: URL) {
 
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    ImageManager.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            }
        }
    }
}
