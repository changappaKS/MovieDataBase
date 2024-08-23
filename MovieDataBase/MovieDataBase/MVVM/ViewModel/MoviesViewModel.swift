//
//  MoviesViewModel.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Model Class for handling all the operations
import Foundation

class MovieViewModel {

    var items: [MovieViewModelSection] = []
    var filteredMovies: [Movie] = []
    var isSearching: Bool = false
    var collapsedState: [MovieViewModelItemType: Bool] = [:]

    init() {
        loadMoviesFromJSON()
        setupInitialCollapseState()
    }
    
    /// Method to load movies from the JSON file
    private func loadMoviesFromJSON() {
        if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: data)
                processMovies(movies: movies)
            } catch {
                debugPrint("Failed to load or decode JSON: \(error)")
            }
        } else {
            debugPrint("Failed to find JSON file.")
        }
    }
    
    /// Method to process the movies into different sections
    func processMovies(movies: [Movie]) {
        var years = Set<String>()
        var genres = Set<String>()
        var directors = Set<String>()
        var actors = Set<String>()
        
        // Process each movie and categorize them
        for movie in movies {
            if let year = movie.year {
                let cleanedYear = year.split(separator: "–").first?.trimmingCharacters(in: .whitespaces) ?? year
                years.insert(cleanedYear)
            }
            if let genre = movie.genre {
                let genreArray = genre.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                genres.formUnion(genreArray)
            }
            if let director = movie.director {
                let directorArray = director.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                directors.formUnion(directorArray)
            }
            if let actor = movie.actors {
                let actorArray = actor.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                actors.formUnion(actorArray)
            }
        }
        
        /// Create section models using MovieViewModelSection
        let yearItem = MovieViewModelSection.year(items: Array(years).sorted())
        let genreItem = MovieViewModelSection.genre(items: Array(genres).sorted())
        let directorItem = MovieViewModelSection.director(items: Array(directors).sorted())
        let actorItem = MovieViewModelSection.actor(items: Array(actors).sorted())
        let allMoviesItem = MovieViewModelSection.allMovies(items: movies)
        
        items = [yearItem, genreItem, directorItem, actorItem, allMoviesItem]
    }
    
    private func setupInitialCollapseState() {
            items.forEach { section in
                collapsedState[section.type] = true
            }
        }

        func toggleCollapseState(for section: MovieViewModelItemType) {
            if let currentState = collapsedState[section] {
                collapsedState[section] = !currentState
            }
        }

        func isCollapsed(section: MovieViewModelItemType) -> Bool {
            return collapsedState[section] ?? true
        }
    
    /// Function to fetch all movies for a given year
    func fetchMoviesByYear(year: String) -> [Movie] {
        return fetchMovies(filter: { movie in
            if let movieYear = movie.year?.split(separator: "–").first?.trimmingCharacters(in: .whitespaces) {
                return movieYear == year
            }
            return false
        })
    }

    /// Function to fetch all movies for a given genre
    func fetchMoviesByGenre(genre: String) -> [Movie] {
        return fetchMovies(filter: { $0.genre?.contains(genre) == true })
    }

    /// Function to fetch all movies for a given actor
    func fetchMoviesByActor(actor: String) -> [Movie] {
        return fetchMovies(filter: { $0.actors?.contains(actor) == true })
    }
    
    func fetchMoviesByDirector(director: String) -> [Movie] {
        return fetchMovies(filter: { $0.director?.contains(director) == true })
    }

    /// Function to fetch all movies for a given director
    private func fetchMovies(filter: @escaping (Movie) -> Bool) -> [Movie] {
        guard let allMoviesItem = items.first(where: { $0.type == .allMovies }) else {
            return []
        }
        
        if case let MovieViewModelSection.allMovies(movies) = allMoviesItem {
            return movies.filter(filter)
        }
        
        return []
    }


    func searchMovies(with query: String) {
            isSearching = !query.isEmpty
            
            if isSearching {
                filteredMovies = fetchMovies(filter: {
                    $0.title?.localizedCaseInsensitiveContains(query) == true ||
                    $0.genre?.localizedCaseInsensitiveContains(query) == true ||
                    $0.actors?.localizedCaseInsensitiveContains(query) == true ||
                    $0.director?.localizedCaseInsensitiveContains(query) == true
                })
            } else {
                filteredMovies = []
            }
        }

        func cancelSearch() {
            isSearching = false
            filteredMovies = []
        }
}
