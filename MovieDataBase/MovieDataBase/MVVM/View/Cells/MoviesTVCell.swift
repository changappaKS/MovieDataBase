//
//  MoviesTVCell.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Movie Details Cell
import UIKit

class MoviesTVCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.posterImageView.image = UIImage(named: AppStrings.ImageNames.folderThumbnail )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImageView.image = UIImage(named: AppStrings.ImageNames.folderThumbnail )
    }
    
    /// Function to configure the cell with a Movie object
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.title
        languageLabel.text = movie.language
        yearLabel.text = movie.year
        ImageLoader.shared.loadImage(from: movie.poster, into: posterImageView)
        setNeedsLayout()
        layoutIfNeeded()
    }
}
