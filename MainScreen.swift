//
//  ViewController.swift
//  Imagely
//
//  Created by Mateen on 9/23/25.
//

import UIKit

class MainScreen: UIViewController {

    var collectionView: UICollectionView?
    var imageManager: ImageManager = ImageManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Main Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
let layout = MasonryLayout()
        layout.numberOfColumns = 3
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageManager.delegate = self
        view.addSubview(collectionView!)
        
        
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.frame = view.bounds
    
        DispatchQueue.main.async {
            self.imageManager.fetchImages()
          
            print(self.imageManager.images)
        }
       

    }
}



extension MainScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageManager.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(image_url: imageManager.images[indexPath.item].download_url)
        return cell
    }
}

extension MainScreen : ImageManagerDelegate {
    func updateUIAfterFetch() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            print("Data reloaded")
        }
    }
    
    
}

// MARK- UICollectionViewDelegateFlowLayout
extension MainScreen : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let itemsPerRow: CGFloat = 3
            let spacing: CGFloat = 2
            let totalSpacing = (itemsPerRow - 1) * spacing
            
            let availableWidth = collectionView.bounds.width - totalSpacing
            let cellWidth = availableWidth / itemsPerRow
            
            let image = imageManager.images[indexPath.row]
            let aspectRatio = CGFloat(image.height) / CGFloat(image.width)
            
            // 🔹 Scale height dynamically
            let cellHeight = cellWidth * aspectRatio
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    
    
}



extension MainScreen: MasonryLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAt indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        let image = imageManager.images[indexPath.item]
        let aspectRatio = CGFloat(image.height) / CGFloat(image.width)
        return width * aspectRatio
    }
}
