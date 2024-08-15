//
//  CategoryView.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Header section View of Movie Database category
import UIKit

class CategoryView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(title: String, isCollapsed: Bool) {
        titleLabel.text = title
        arrowImage.image = isCollapsed ? UIImage(systemName: "chevron.right") : UIImage(systemName: "chevron.down")
    }
}
