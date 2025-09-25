//
//  ViewController.swift
//  Imagely
//
//  Created by Mateen on 9/23/25.
//

import UIKit

class MainScreen: UIViewController {
    var isGridLayout = true
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
    
    
    //MARK: - Screen creation and fetching methods
    func fetchImages() {
        ImageManager.fetchImages()
    }
    
    func mainScreenSetup(){
        view.backgroundColor = .systemBackground
        title = "Main Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", image: UIImage(systemName: "square.grid.2x2"), target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        isGridLayout.toggle()
        
        let newLayout: UICollectionViewLayout = isGridLayout
            ? createLayoutTwoColumns()
            : createLayout()
        
        collectionView?.setCollectionViewLayout(newLayout, animated: true)
        
        navigationItem.rightBarButtonItem?.image = isGridLayout
            ? UIImage(systemName: "square.grid.2x2")
            : UIImage(systemName: "rectangle.grid.1x2")
    }
    
    func collectionViewSetup() {
        let layout = createLayoutTwoColumns()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.frame = view.bounds
        view.addSubview(collectionView!)
    }
    
    
    //MARK: - Layout Methods
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



func createLayoutTwoColumns() -> UICollectionViewCompositionalLayout {
   //Items
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
   
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3)), subitems: [item,item])

   //Sections
   let section = NSCollectionLayoutSection(group: group)
  
   //Return
   return UICollectionViewCompositionalLayout(section: section)
  

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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationCapturesStatusBarAppearance = true
        let url = ImageManager.images[indexPath.row].download_url
        if let image = ImageManager.imageCache.object(forKey: url as NSString) {
            
            vc.config(with: image)

            navigationController?.pushViewController(vc, animated: true)
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



