//
//  ImageLoader.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Image Loader Singleton Class to load Images Asynchronously

import UIKit

class ImageLoader {
    static let shared = ImageLoader() /// Singleton instance
    
    private init() { }
    
    /// Loads an image from a URL into a UIImageView, with a placeholder image if the download fails or the URL is invalid.
    /// - Parameters:
    ///   - urlString: The URL string of the image to load.
    ///   - imageView: The UIImageView where the image will be displayed.
    ///   - placeholder: The name of the placeholder image to display if the download fails or the URL is invalid.
    func loadImage(from urlString: String?, into imageView: UIImageView, placeholder: String = "folderThumbnail") {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            /// If the URL is invalid, set the placeholder image
            imageView.image = UIImage(named: placeholder )
            return
        }
        
        imageView.image = UIImage(named: placeholder)
        
        /// Asynchronous image loading
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: placeholder)
                }
                return
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: placeholder)
                }
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = downloadedImage
            }
        }.resume()
    }
}
