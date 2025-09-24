//
//  ImageManager.swift
//  Imagely
//
//  Created by Mateen on 9/23/25.
//

import Foundation
import UIKit

//Class instead of struct for mutating reasons
 class ImageManager {
     private init(){}
    static var delegate : ImageManagerDelegate?
    static var images: [Image] = []
     static var imageCache = NSCache<NSString, UIImage>()
     static func fetchImages() {
        
        let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=30")!
        let request = URLRequest(url: url)


        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { return }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let json: [Image] = try decoder.decode([Image].self, from: data)
                self.completionOnFetch(images: json)
                print("Images fetched")
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
     static func completionOnFetch(images : [Image]) {
        self.images.removeAll()
        self.images.append(contentsOf: images)
         delegate?.updateUIAfterFetch()
    }
}
