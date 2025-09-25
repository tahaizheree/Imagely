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
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.frame = view.bounds
        view.addSubview(collectionView!)
    }
    
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


extension MainScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
       
        let lastIndex = ImageManager.images.count - 1
        if indexPath.item == lastIndex {
            ImageManager.fetchImages()
        }
    }
}
extension MainScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageManager.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
      
            cell.configure(index:indexPath.row,image_url: ImageManager.images[indexPath.item].download_url)
 
        return cell
    }
    
   
    
}




//MARK: - Image Manager Delegates
extension MainScreen : ImageManagerDelegate {
    func updateUIAfterFetch() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            print("Data reloaded")
        }
    }
}



