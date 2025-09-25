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
    var stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.frame = view.bounds
        imageView.frame = view.bounds
        
        view.addSubview(stackView)
        view.backgroundColor = .black
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        shareButton.tintColor = .white
        shareButton.imageView?.contentMode = .scaleAspectFill
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(shareButton,at: 1)
        // Do any additional setup after loading the view.
        NSLayoutConstraint.activate(
            [
                shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
                shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            ]
        )
    }
    
    
    func config(with image: UIImage) {
        imageView.image = image
        stackView.insertSubview(imageView, at: 0)
        imageView.contentMode = .scaleAspectFit
    }
    
}
