//
//  UILabel+Extension.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

import UIKit

extension UILabel {
    /// setting different fonts for strings within a label
    func setAttributedText(title: String, value: String?, titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16),
                           valueFont: UIFont = UIFont.systemFont(ofSize: 16)) {
        let titleAttributes: [NSAttributedString.Key: Any] = [.font: titleFont]
        let valueAttributes: [NSAttributedString.Key: Any] = [.font: valueFont]
        
        let attributedText = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let valueString = NSAttributedString(string: " \(value ?? "-")", attributes: valueAttributes)
        
        attributedText.append(valueString)
        self.attributedText = attributedText
    }
}

