//
//  ViewController.swift
//  Imagely
//
//  Created by Mateen on 9/23/25.
//

import UIKit

class MainScreen: UIViewController {
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        ImageManager.delegate = self
        
        //Main Screen Setup
        mainScreenSetup()
        
        //Collection View Setup
        collectionViewSetup()
        
        //Fetch Images
        fetchImages()
        
    }
    
    func fetchImages() {
        ImageManager.fetchImages()
    }
    
    func mainScreenSetup(){
        view.backgroundColor = .systemBackground
        title = "Main Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func collectionViewSetup() {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        //        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.frame = view.bounds
        view.addSubview(collectionView!)
    }
//    func createLayout() -> UICollectionViewCompositionalLayout {
//        // Define the size of each item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//        
//        // Define the size of the group (a row of items)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        // Define the section
//        let section = NSCollectionLayoutSection(group: group)
//        
//        return UICollectionViewCompositionalLayout(section: section)
//    }
//    
//}
     func createLayout() -> UICollectionViewCompositionalLayout {
        //Items
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)))
         item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
         let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5, )))
         verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        //Groups
          
         let verticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitems: [verticalStackItem])
         
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2.5/5)), subitems: [item,verticalStackGroup])
         let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2.5/5)), subitems: [verticalStackGroup,item])
         
         let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [group,group2])
         

        //Sections
        let section = NSCollectionLayoutSection(group: mainGroup)
       
        //Return
        return UICollectionViewCompositionalLayout(section: section)
       
    }
}


//MARK: - Collection View Delegates
extension MainScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageManager.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
      
            cell.configure(index:indexPath.row,image_url: ImageManager.images[indexPath.item].download_url)
        
    
        print("Row: \(indexPath.row)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
//
//extension MainScreen : UICollectionViewDelegateFlowLayout {
//    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: 130, height: 150)
////    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        2
//    }
//    
//}
//


//MARK: - Image Manager Delegates
extension MainScreen : ImageManagerDelegate {
    func updateUIAfterFetch() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            print("Data reloaded")
        }
    }
}





extension MainScreen: MasonryLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAt indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        let image = ImageManager.images[indexPath.item]
        let aspectRatio = CGFloat(image.height) / CGFloat(image.width)
        return width * aspectRatio
    }
}
