//
//  DefaultImageView.swift
//  Marvel
//
//  Created by Mac on 19/06/2023.
//

import UIKit
import Kingfisher

class DefaultImageView: UIImageView {
    func setImage(thumbnail:String){
        let placeHolder = #imageLiteral(resourceName: "marvel-placeholder")
        if let imageURL = URL(string: thumbnail) {
            let resource = KF.ImageResource(downloadURL: imageURL)
            kf.indicatorType = .activity
            kf.setImage(with: resource, placeholder: placeHolder)
        }else{
            image = placeHolder
        }
    }

}
