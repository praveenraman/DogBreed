//
//  DogBreedScreenVC.swift
//  DogBreed
//
//  Created by Praveen Kumar on 10/07/24.
//

protocol FavoriteBreedDelegate {
    func FavoriteBreed(fvBreedData: [BreedData])
}

import UIKit

class DogBreedScreenVC: UIViewController {
    
    @IBOutlet weak var breedCollectionView: UICollectionView!
    var nameBreed: String?
   
    var currentStep: String?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var breedData = [BreedData]()
    
    var favoriteBreedDelegate: FavoriteBreedDelegate!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.title = nameBreed?.capitalized
        configeCollectionView()
        loadBreedData(nameBreed: nameBreed, favData: breedData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configeCollectionView(){
        self.breedCollectionView.register(UINib(nibName: "BreedCVCell", bundle: nil), forCellWithReuseIdentifier: "BreedCVCell")
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        breedCollectionView.collectionViewLayout = layout
    }
    
    func loadBreedData(nameBreed: String?, favData: [BreedData]){
        if nameBreed != nil{
            let queue = DispatchQueue(label: "Solid", qos: .utility)
            queue.sync {
                DataManager().getDogsBreedsRandomResponse(url: Urls.breedImagesUrl(imgName: nameBreed ?? "")) { result in
                    switch result {
                    case .success(let data):
                        for message in data.message{
                            let breed = BreedData(message: message, isSelected: false)
                            self.breedData.append(breed)
                            DispatchQueue.main.async{
                                self.breedCollectionView.reloadData()
                            }
                        }
                    case .failure(let error):
                        Common.showAlert(title: "Alert!", message: error.localizedDescription, viewController: self)
                    }
                }
            }
        }else{
            self.breedData = FavoriteBreedResponse.shared.breedData
            self.breedData = removeDuplicateElements()
            DispatchQueue.main.async{
                self.breedCollectionView.reloadData()
            }
        }
        
        func removeDuplicateElements() -> [BreedData] {
            var uniquePosts = [BreedData]()
            for post in breedData {
                if !uniquePosts.contains(where: {$0.message == post.message }) {
                    uniquePosts.append(post)
                }
            }
            return uniquePosts
        }
    }
    
    @IBAction func goToBack(_ sender: Any){
        for data in breedData{
            if data.isSelected == true{
                FavoriteBreedResponse.shared.breedData.append(data)
            }
        }
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
}

extension DogBreedScreenVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return breedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedCVCell", for: indexPath as IndexPath) as? BreedCVCell else{
            return UICollectionViewCell()
        }
        cell.likeBtn.tag = indexPath.row
        cell.loadBreedImageData(breedData: breedData[indexPath.row])
        cell.likeBtn.addTarget(self, action: #selector(onClickRate1(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func onClickRate1(sender: UIButton){
        let cell = breedCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! BreedCVCell
        if breedData[sender.tag].isSelected == false {
            cell.likeUnlikeImg.image = UIImage(named: "heartFill")
            breedData[sender.tag].isSelected = true
           // FavoriteBreedResponse.shared.breedData.append(breedData[sender.tag])
        }else{
            breedData[sender.tag].isSelected = false
            cell.likeUnlikeImg.image = UIImage(named: "heart")
        }
    }
}

extension DogBreedScreenVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2 - 10
        return CGSize(width: width, height: 140)
    }
}
