//
//  MovieSectionTVCell.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Section cells
import UIKit

class MovieSectionTVCell: UITableViewCell {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var arrowLabel: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
