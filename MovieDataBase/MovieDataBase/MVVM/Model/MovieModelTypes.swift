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

/// Define the MovieViewModelSection struct to handle different section types
import Foundation

enum MovieViewModelSection {
    case year(items: [String])
    case genre(items: [String])
    case director(items: [String])
    case actor(items: [String])
    case allMovies(items: [Movie])
    
    /// Type of section
    var type: MovieViewModelItemType {
        switch self {
        case .year: return .year
        case .genre: return .genre
        case .director: return .director
        case .actor: return .actor
        case .allMovies: return .allMovies
        }
    }
    
    /// section title for each header
    var sectionTitle: String {
        switch self {
        case .year: return AppStrings.SectionTitles.year
        case .genre: return AppStrings.SectionTitles.genre
        case .director: return AppStrings.SectionTitles.directors
        case .actor: return AppStrings.SectionTitles.actors
        case .allMovies: return AppStrings.SectionTitles.allMovies
        }
    }
    
    /// Number of items present in each section
    var rowCount: Int {
        switch self {
        case .year(let items),
             .genre(let items),
             .director(let items),
             .actor(let items):
            return items.count
        case .allMovies(let items):
            return items.count
        }
    }
    
    /// Item at each section
    func item(at index: Int) -> Any {
        switch self {
        case .year(let items),
             .genre(let items),
             .director(let items),
             .actor(let items):
            return items[index]
        case .allMovies(let items):
            return items[index]
        }
    }
}
