//
//  ViewController.swift
//  task
//
//  Created by Mac on 2023-04-26.
//

import UIKit




class ViewController: UIViewController {
  
    lazy var viewModel = {
        GalleryViewModel()
    }()

    
    @IBOutlet weak var fflowwlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionArr:Gallery?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initView()
       // serviceapi()
        
//        let flowLayout: UICollectionViewFlowLayout = {
//            let layout = UICollectionViewFlowLayout()
//            layout.minimumInteritemSpacing = 5
//            layout.minimumLineSpacing = 5
//            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//            return layout
//        }()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
       // collectionView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
       // collectionView.allowsSelection = false
        collectionView.collectionViewLayout = CustomCircularCollectionViewLayout()

       // collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
     
    }
    
    func serviceapi(){
        var request = URLRequest(url: URL(string: "https://test.dev-fsit.com/api/image-list")!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { [self] data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                collectionArr = try jsonDecoder.decode(Gallery.self, from: data!)
                print(collectionArr)
                
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
    
    
    

    func initViewModel() {
        // Get employees data
        viewModel.getEmployees()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }


//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.employeeCellViewModels.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = UICollectionViewCell.cellForItem(at: indexPath.row)
//                //collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
//                                                            for: indexPath) as? CollectionViewCell else {
//            fatalError("Wrong cell class dequeued")}
//        //guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewcellCollectionViewCell else { fatalError("xib does not exists") }
//      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        //collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewcellCollectionViewCell
//
//        //cell.galleryImage.imageFromUrl(urlString: cellVM.data[indexPath.item].image ?? "")
//       // cell.gallerrLbl.text = "\(cellVM.data[indexPath.item].title ?? "")"
//        //cell.galleryImage.image =  UIImage(named: "\(cellVM.employeeCellViewModels[indexPath.item].image)")
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           let width = collectionView.bounds.width
//           let numberOfItemsPerRow: CGFloat = 3
//           let spacing: CGFloat = fflowwlayout.minimumInteritemSpacing
//           let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
//           let itemDimension = floor(availableWidth / numberOfItemsPerRow)
//           return CGSize(width: itemDimension, height: itemDimension)
//       }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // let cellVM = viewModel.getCellViewModel(at: section)
        
        return viewModel.employeeCellViewModels.count
        //(viewModel.employees?.data.count)!
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        print(cellVM)
        cell.galleryImage.imageFromUrl(urlString: cellVM.data[indexPath.item].image ?? "")
        cell.gallerrLbl.text = "\(cellVM.data[indexPath.item].title ?? "")"
        
        //cell.galleryImage.imageFromUrl(urlString: collectionArr!.data[indexPath.item].image ?? "")
        //cell.gallerrLbl.text = "\(collectionArr!.data[indexPath.item].title ?? "")"
        

        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = fflowwlayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)


       // return CGSize(width: 200, height: 300)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // print(movies[indexPath.row].title)
    }
}
