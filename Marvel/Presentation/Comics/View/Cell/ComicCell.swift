//
//  ComicCell.swift
//  Marvel
//
//  Created by Mac on 19/06/2023.
//

import UIKit

class ComicCell: UITableViewCell {

    
    @IBOutlet weak var indicatorContainer: UIView!

    
    @IBOutlet weak var labelsContainer: UIView!
    
    @IBOutlet weak var comicImage: DefaultImageView!
    
 
    @IBOutlet weak var comicTitle: UILabel!
    
    @IBOutlet weak var comicReleaseDate: UILabel!
    
    @IBOutlet weak var stackBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ImageBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
      
    }
    
    func configCell(thumbnail: String) {
        comicImage.setImage(thumbnail: thumbnail)
        
    }
    
    func configCell(thumbnail: String,isExpanded: Bool, title: String, date: String,isFetching: Bool) {
        comicImage.contentMode = .scaleAspectFill
        comicImage.setImage(thumbnail: thumbnail)
        comicTitle.text = title
        comicReleaseDate.text = date
        expandCell(isExpanded: isExpanded, isFetching: isFetching)
    }

    func expandCell(isExpanded: Bool,isFetching: Bool) {
        if isExpanded {
            labelsContainer.isHidden = isFetching
            indicatorContainer.isHidden = !isFetching
            stackBottomConstraint.priority = .defaultHigh
            ImageBottomConstraint.priority = .defaultLow
            setupConstraintHeight()
        }else{
            stackBottomConstraint.priority = .defaultLow
            ImageBottomConstraint.priority = .defaultHigh
        }
    }
    
    func setupConstraintHeight() {
        comicTitle.sizeToFit()
        stackBottomConstraint.constant = comicTitle.frame.size.height + 50
        stackBottomConstraint.priority = .defaultHigh
        ImageBottomConstraint.priority = .defaultLow
        layoutIfNeeded()
    }
    
}
