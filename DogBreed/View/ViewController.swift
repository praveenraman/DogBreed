//
//  ViewController.swift
//  DogBreed
//
//  Created by Praveen Kumar on 09/07/24.
//

import UIKit


class ViewController: UIViewController {
    
    var breedData = [BreedData]()
    var fvBreedData = [BreedData]()
    
    @IBOutlet weak var breedCollectionView: UICollectionView!
    var currentStep: String?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
   
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.title = "Breed"
        configeCollectionView()
        loadBreedData()
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
    
    func loadBreedData(){
        let queue = DispatchQueue(label: "Solid", qos: .utility)
        queue.sync {
            DataManager().getDogsBreedsResponse { result in
                switch result {
                case .success(let data):
                    for message in data.message{
                        let breed = BreedData(message: message, isSelected: false)
                        self.breedData.append(breed)
                    }
                    DispatchQueue.main.async{
                        self.breedCollectionView.reloadData()
                    }
                case .failure(let error):
                    Common.showAlert(title: "Alert!", message: error.localizedDescription, viewController: self)
                }
            }
        }
    }
    
    @IBAction func favoritePics(_ sender: Any){
        if FavoriteBreedResponse.shared.breedData.count > 0{
            guard let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DogBreedScreenVC") as? DogBreedScreenVC else{
                return
            }
            controller.favoriteBreedDelegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            Common.showAlert(title: "Alert!", message: "Data Not Found", viewController: self)
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return breedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedCVCell", for: indexPath as IndexPath) as? BreedCVCell else{
            return UICollectionViewCell()
        }
        cell.loadBreedData(breedData: breedData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DogBreedScreenVC") as? DogBreedScreenVC else{
            return
        }
        controller.nameBreed = breedData[indexPath.row].message
        controller.favoriteBreedDelegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2 - 10
        return CGSize(width: width, height: 140)
    }
}

extension ViewController: FavoriteBreedDelegate {
    func FavoriteBreed(fvBreedData: [BreedData]){
        self.fvBreedData = fvBreedData
    }
}
