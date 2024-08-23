//
//  MovieDetailsViewController.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Movie Details View Control

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var castCrewLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    @IBOutlet weak var ratingControl: RatingControlView!
    @IBOutlet weak var genreLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateTextViewHeight()
        navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    /// update the UI details
    func setupView() {
        guard let movie = movie else { return }
        self.title = AppStrings.TitleStrings.movieDetails
        movieTitleLabel.text = movie.title
        plotTextView.text = "\(AppStrings.LabelTitles.plot) \n\n \(movie.plot ?? "")"
        castCrewLabel.setAttributedText(title: AppStrings.LabelTitles.starring, value: movie.actors)
        directorLabel.setAttributedText(title: AppStrings.LabelTitles.director, value: movie.director)
        languageLabel.setAttributedText(title: AppStrings.LabelTitles.language, value: movie.language)
        writerLabel.setAttributedText(title: AppStrings.LabelTitles.writer, value: movie.writer)
        genreLabel.setAttributedText(title: AppStrings.LabelTitles.genre, value: movie.genre)
        yearsLabel.setAttributedText(title: AppStrings.LabelTitles.releaseDate, value: movie.year)
        ratingControl.configure(with: movie.ratings)
        ImageLoader.shared.loadImage(from: movie.poster, into: moviePosterImageView)
    }

    /// make sure that textview is not scrollable and height is adjusted correctly
    private func updateTextViewHeight() {
        plotTextView.isScrollEnabled = false
        plotTextView.sizeToFit()
        plotTextView.layoutIfNeeded()
    }
}
