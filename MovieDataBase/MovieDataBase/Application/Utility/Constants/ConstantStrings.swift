//
//  ConstantStrings.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

import Foundation

enum AppStrings {
    
    enum ImageNames {
        static let folderThumbnail = "folderThumbnail"
    }

    enum SectionTitles {
        static let actors = "Actors"
        static let allMovies = "All Movies"
        static let directors = "Directors"
        static let genre = "Genre"
        static let year = "Years"
    }

    enum ByTitles {
        static let moviesFrom = "Movies from"
        static let moviesIn = "Movies in"
        static let moviesBy = "Movies by"
        static let moviesWith = "Movies with"
    }

    enum TitleStrings {
        static let movieDatabase = "Movie Database"
        static let movieDetails = "Movie Details"
    }

    enum LabelTitles {
        static let starring = "Starring: "
        static let director = "Director: "
        static let language = "Language: "
        static let writer = "Writer: "
        static let genre = "Genre: "
        static let releaseDate = "Release Date: "
        static let plot = "PLOT :"
        static let rating = "Rating: "
        
        static let ratingTypes = """
        IMDB: Internet Movie Database
        RT: Rotten Tomatoes
        MC: Metacritic
        """
    }

    enum RatingSources {
        static let sources: [String: String] = [
            "Internet Movie Database": "IMDB",
            "Rotten Tomatoes": "RT",
            "Metacritic": "MC"
        ]
    }
}

enum AppIdentifiers {
    
    enum CellIdentifiers {
        static let moviesTVCell = "MoviesTVCell"
        static let movieSectionTVCell = "MovieSectionTVCell"
    }
    
    enum ViewControllerIdentifiers {
        static let movieDetailsVC = "MovieDetailsViewController"
        static let movieListVC = "MovieListViewController"
    }

    enum NibName {
        static let categoryView = "CategoryView"
    }
}
