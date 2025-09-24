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
            Thread.isMainThread ? print("Main Thread while loading") : print("Not main thread while loading")
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    ImageManager.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                        print("Image downloaded : \(index)")
                    }
                }
            }
        }
    }
}

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
