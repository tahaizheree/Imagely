//
//  CustomCollectionViewCell.swift
//  Imagely
//
//  Created by Mateen on 9/23/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"

    private let myImageView:  UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)}
    
    func configure(index:Int,image_url: String){
        let obj = ImageManager.imageCache.object(forKey: image_url as NSString)
        if(obj != nil) {
            myImageView.image = obj
        }
        else{
            myImageView.load(index:index,url: URL(string: image_url)!)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}







