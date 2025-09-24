//
//  CustomCollectionViewCell.swift
//  Imagely
//
//  Created by Mateen on 9/23/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCllectionViewCell"
    private let myImageView:  UIImageView = {
            let imageView = UIImageView()
      
//        imageView.image = UIImage(named: "Imagely")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let myLabel:  UILabel = {
            let uiLabel = UILabel()
        uiLabel.textColor = .black
        uiLabel.textAlignment = .center
        uiLabel.backgroundColor = .white
        uiLabel.text = "Custom"
        return uiLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myImageView)
//        contentView.addSubview(myLabel)
        contentView.clipsToBounds = true
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width - 10, height: 50)
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)}
    
    
    
    func configure(image_url: String){
        myImageView.load(url: URL(string: image_url)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}



extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}




