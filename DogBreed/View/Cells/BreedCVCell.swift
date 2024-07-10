//
//  BreedCVCell.swift
//  DogBreed
//
//  Created by Praveen Kumar on 09/07/24.
//

import UIKit

class BreedCVCell: UICollectionViewCell {
    
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var breedImg: ImageViewHandler!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeUnlikeImg: UIImageView!
    @IBOutlet weak var fvView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 8
        fvView.layer.cornerRadius = fvView.frame.size.height/2
        breedImg.isHidden = true
        fvView.isHidden = true
    }
    
    func loadBreedData(breedData: BreedData?){
        breedImg.isHidden = true
        fvView.isHidden = true
        breedName.text = breedData?.message ?? ""
    }
    
    func loadBreedImageData(breedData: BreedData?){
        breedImg.isHidden = false
        fvView.isHidden = false
        if let name = breedData?.message {
            breedImg.loadAsyncFrom(url: name, placeholder:  UIImage(named: "User"))
        }
        if breedData?.isSelected == true{
            likeUnlikeImg.image = UIImage(named: "heartFill")
        }else{
            likeUnlikeImg.image = UIImage(named: "heart")
        }
    }
}
