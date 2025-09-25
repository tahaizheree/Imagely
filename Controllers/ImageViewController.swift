//
//  ImageViewController.swift
//  Imagely
//
//  Created by Mateen on 9/25/25.
//

import UIKit

class ImageViewController: UIViewController {
    
    var shareButton = UIButton()
    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = view.bounds
        view.insertSubview(imageView, at: 0)
        imageView.contentMode = .scaleAspectFit
        view.backgroundColor = .black
        setupShareButton()
        // Do any additional setup after loading the view.
       
    }
    
    private func setupShareButton(){
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        shareButton.tintColor = .white
        shareButton.imageView?.contentMode = .scaleAspectFill
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(shareButton,at: 1)
        
        NSLayoutConstraint.activate(
            [
                shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
                shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            ]
        )
    }
    
    func config(with image: UIImage) {
        imageView.image = image
    }
    
}
