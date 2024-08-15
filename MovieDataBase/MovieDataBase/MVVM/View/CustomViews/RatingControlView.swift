//
//  RatingControlView.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Custom Rating Control View
import UIKit

class RatingControlView: UIControl {

    private var ratings: [Rating] = []
    
    private var headerLabel: UILabel!
    private var segmentedControl: UISegmentedControl!
    private var ratingLabel: UILabel!
    private var infoButton: UIButton!
    private var popoverView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        /// Set up the header label
        headerLabel = UILabel()
        headerLabel.text = AppStrings.LabelTitles.rating
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headerLabel.textAlignment = .left
        addSubview(headerLabel)

        /// Set up the segmented control
        segmentedControl = UISegmentedControl(items: [])
        segmentedControl.addTarget(self, action: #selector(ratingSourceChanged(_:)), for: .valueChanged)
        addSubview(segmentedControl)
        
        /// Set up the info button
        infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(showRatingSourceInfo), for: .touchUpInside)
        addSubview(infoButton)
        
        /// Set up the label to display the rating value
        ratingLabel = UILabel()
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(ratingLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            infoButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 8),
            infoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    /// Configure the control with ratings
    func configure(with ratings: [Rating]?) {
        guard let ratings = ratings else { return }
        self.ratings = ratings
        
        segmentedControl.removeAllSegments()
        for (index, rating) in ratings.enumerated() {
            let shortName = shortNameForRatingSource(rating.source ?? "")
            segmentedControl.insertSegment(withTitle: shortName, at: index, animated: false)
        }
        
        /// Select the first rating by default
        if !ratings.isEmpty {
            segmentedControl.selectedSegmentIndex = 0
            updateRatingLabel(for: ratings[0].value)
        }
    }

    // Map full rating source names to short names
    private func shortNameForRatingSource(_ source: String) -> String {
        return AppStrings.RatingSources.sources[source] ?? source
    }

    @objc private func ratingSourceChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        let selectedRating = ratings[selectedIndex]
        updateRatingLabel(for: selectedRating.value)
    }

    private func updateRatingLabel(for value: String?) {
        ratingLabel.text = value
    }

    /// Show a popover with full rating source names
    @objc private func showRatingSourceInfo() {
        if popoverView != nil {
            hidePopover()
        } else {
            displayPopover()
        }
    }

    private func displayPopover() {
        let popoverWidth: CGFloat = 200
        let popoverHeight: CGFloat = 100
        
        let popoverX = infoButton.frame.minX - popoverWidth - 8
        let popoverY = infoButton.frame.midY - (popoverHeight / 2)
        
        popoverView = UIView(frame: CGRect(x: popoverX, y: popoverY, width: popoverWidth, height: popoverHeight))
        popoverView?.backgroundColor = UIColor.black
        popoverView?.layer.cornerRadius = 8
        popoverView?.layer.borderWidth = 1
        popoverView?.layer.borderColor = UIColor.gray.cgColor

        let label = UILabel(frame: CGRect(x: 8, y: 8, width: popoverWidth - 16, height: popoverHeight - 16))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = AppStrings.LabelTitles.ratingTypes
        popoverView?.addSubview(label)

        addSubview(popoverView!)
    }

    private func hidePopover() {
        popoverView?.removeFromSuperview()
        popoverView = nil
    }
}
