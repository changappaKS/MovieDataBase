//
//  MovieModelTypes.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

import Foundation

/// Define the number of Sections
enum MovieViewModelItemType {
    case year
    case genre
    case director
    case actor
    case allMovies
}

/// Define common properites required for each cell
protocol MovieViewModelItem {
    var type: MovieViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var isCollapsed: Bool { get set }
}

/// Model for the "Year" section
class MovieViewModelYearItem: MovieViewModelItem {
    var type: MovieViewModelItemType { return .year }
    var sectionTitle: String { return AppStrings.SectionTitles.year }
    var isCollapsed: Bool = true         /// Section is initially collapsed
    
    var years: [String]
    var rowCount: Int { return years.count }

    init(years: [String]) {
        self.years = years           
    }
}

/// Model for the "Genre" section
class MovieViewModelGenreItem: MovieViewModelItem {
    var type: MovieViewModelItemType { return .genre }
    var sectionTitle: String { return AppStrings.SectionTitles.genre }
    var isCollapsed: Bool = true
    
    var genres: [String]
    var rowCount: Int { return genres.count }

    init(genres: [String]) {
        self.genres = genres           
    }
}

/// Model for the "Directors" section
class MovieViewModelDirectorItem: MovieViewModelItem {
    var type: MovieViewModelItemType { return .director }
    var sectionTitle: String { return AppStrings.SectionTitles.directors }
    var isCollapsed: Bool = true
    
    var directors: [String]
    var rowCount: Int { return directors.count }

    init(directors: [String]) {
        self.directors = directors
    }
}

/// Model for the "Actors" section
class MovieViewModelActorItem: MovieViewModelItem {
    var type: MovieViewModelItemType { return .actor }
    var sectionTitle: String { return AppStrings.SectionTitles.actors }
    var isCollapsed: Bool = true
    
    var actors: [String]
    var rowCount: Int { return actors.count }

    init(actors: [String]) {
        self.actors = actors
    }
}

/// Model for the "All Movies" section
class MovieViewModelAllMoviesItem: MovieViewModelItem {
    var type: MovieViewModelItemType { return .allMovies }
    var sectionTitle: String { return AppStrings.SectionTitles.allMovies }
    var isCollapsed: Bool = true
    
    var movies: [Movie]
    var rowCount: Int { return movies.count }

    init(movies: [Movie]) {
        self.movies = movies   
    }
}
