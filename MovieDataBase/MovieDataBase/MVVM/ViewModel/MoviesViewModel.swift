//
//  MoviesViewModel.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Model Class for handling all the operations
import Foundation

class MovieViewModel {

    var items: [MovieViewModelItem] = []
    var filteredMovies: [Movie] = []
    var isSearching: Bool = false

    init() {
        loadMoviesFromJSON()
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
    private func processMovies(movies: [Movie]) {
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
        
        /// Create section models
        let yearItem = MovieViewModelYearItem(years: Array(years).sorted())
        let genreItem = MovieViewModelGenreItem(genres: Array(genres).sorted())
        let directorItem = MovieViewModelDirectorItem(directors: Array(directors).sorted())
        let actorItem = MovieViewModelActorItem(actors: Array(actors).sorted())
        let allMoviesItem = MovieViewModelAllMoviesItem(movies: movies)
        
        items = [yearItem, genreItem, directorItem, actorItem, allMoviesItem]
    }
    
    /// Function to fetch all movies for a given year
    func fetchMoviesByYear(year: String) -> [Movie] {
        let filteredMovies = items.compactMap { item -> [Movie]? in
            if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                return allMoviesItem.movies.filter { movie in
                    // Extract the starting year from the movie's year
                    if let movieYear = movie.year?.split(separator: "–").first?.trimmingCharacters(in: .whitespaces) {
                        return movieYear == year
                    }
                    return false
                }
            }
            return nil
        }
        return filteredMovies.flatMap { $0 }
    }

    /// Function to fetch all movies for a given genre
    func fetchMoviesByGenre(genre: String) -> [Movie] {
        let filteredMovies = items.compactMap { item -> [Movie]? in
            if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                return allMoviesItem.movies.filter { $0.genre?.contains(genre) == true }
            }
            return nil
        }
        return filteredMovies.flatMap { $0 }
    }

    /// Function to fetch all movies for a given actor
    func fetchMoviesByActor(actor: String) -> [Movie] {
        let filteredMovies = items.compactMap { item -> [Movie]? in
            if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                return allMoviesItem.movies.filter { $0.actors?.contains(actor) == true }
            }
            return nil
        }
        return filteredMovies.flatMap { $0 }
    }

    /// Function to fetch all movies for a given director
    func fetchMoviesByDirector(director: String) -> [Movie] {
        let filteredMovies = items.compactMap { item -> [Movie]? in
            if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                return allMoviesItem.movies.filter { $0.director?.contains(director) == true }
            }
            return nil
        }
        return filteredMovies.flatMap { $0 }
    }

    /// Method to search movie with given parameter
    func searchMovies(with query: String) {
        isSearching = !query.isEmpty
        
        if isSearching {
            filteredMovies = items.flatMap { item -> [Movie] in
                if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                    return allMoviesItem.movies.filter {
                        $0.title?.localizedCaseInsensitiveContains(query) == true ||
                        $0.genre?.localizedCaseInsensitiveContains(query) == true ||
                        $0.actors?.localizedCaseInsensitiveContains(query) == true ||
                        $0.director?.localizedCaseInsensitiveContains(query) == true
                    }
                }
                return []
            }
        } else {
            filteredMovies = []
        }
    }

    /// Cancel Search Actions
    func cancelSearch() {
        isSearching = false
        filteredMovies = []
    }
}
