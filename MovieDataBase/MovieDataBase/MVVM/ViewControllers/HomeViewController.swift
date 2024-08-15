//
//  HomeViewController.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Home Screen
import UIKit

class HomeViewController: UIViewController {
    let viewModel = MovieViewModel()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var homeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppStrings.TitleStrings.movieDatabase
        navigationController?.navigationBar.tintColor = UIColor.gray
        setupView()
    }

    func setupView() {
        homeTableView.register(UINib(nibName: AppIdentifiers.CellIdentifiers.moviesTVCell, bundle: nil),
                               forCellReuseIdentifier: AppIdentifiers.CellIdentifiers.moviesTVCell)
        homeTableView.register(UINib(nibName: AppIdentifiers.CellIdentifiers.movieSectionTVCell, bundle: nil),
                               forCellReuseIdentifier: AppIdentifiers.CellIdentifiers.movieSectionTVCell)
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.rowHeight = UITableView.automaticDimension
        
        ///set the delegate of search bar
        searchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(with: searchText)
        homeTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.cancelSearch()
        homeTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isSearching ? 1 : viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearching {
            return viewModel.filteredMovies.count
        } else {
            let item = viewModel.items[section]
            return item.isCollapsed ? 0 : item.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isSearching {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.CellIdentifiers.moviesTVCell, for: indexPath) as? MoviesTVCell else {
                return UITableViewCell()
            }
            let movie = viewModel.filteredMovies[indexPath.row]
            cell.configure(with: movie)
            cell.selectionStyle = .none
            return cell
        } else {
            let item = viewModel.items[indexPath.section]
            
            switch item.type {
            case .year, .genre, .director, .actor:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.CellIdentifiers.movieSectionTVCell, for: indexPath) as? MovieSectionTVCell else {
                    return UITableViewCell()
                }
                switch item.type {
                case .year:
                    if let yearItem = item as? MovieViewModelYearItem {
                        cell.sectionTitle.text = yearItem.years[indexPath.row]
                    }
                case .genre:
                    if let genreItem = item as? MovieViewModelGenreItem {
                        cell.sectionTitle.text = genreItem.genres[indexPath.row]
                    }
                case .director:
                    if let directorItem = item as? MovieViewModelDirectorItem {
                        cell.sectionTitle.text = directorItem.directors[indexPath.row]
                    }
                case .actor:
                    if let actorItem = item as? MovieViewModelActorItem {
                        cell.sectionTitle.text = actorItem.actors[indexPath.row]
                    }
                default:
                    break
                }
                
                /// Different background color or font based on section type
                switch item.type {
                case .year:
                    cell.backgroundColor = UIColor.systemGray6
                case .genre:
                    cell.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05)
                case .director:
                    cell.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.05)
                case .actor:
                    cell.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.05)
                default:
                    break
                }
                cell.selectionStyle = .none
                
                return cell
            case .allMovies:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.CellIdentifiers.moviesTVCell, for: indexPath) as? MoviesTVCell else {
                    return UITableViewCell()
                }
                if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                    let movie = allMoviesItem.movies[indexPath.row]
                    cell.configure(with: movie)
                }
                cell.selectionStyle = .none
                cell.layoutIfNeeded()
                return cell
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.isSearching {
            return nil
        }
        
        guard let categoryView = Bundle.main.loadNibNamed(AppIdentifiers.NibName.categoryView,
                                                          owner: self, options: nil)?.first as? CategoryView else {
            return nil
        }
        
        let item = viewModel.items[section]
        categoryView.configureCell(title: item.sectionTitle, isCollapsed: item.isCollapsed)
        
        /// Customize background color based on section type with dynamic colors
        switch item.type {
        case .year:
            categoryView.bgView.backgroundColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.systemCyan.withAlphaComponent(0.6) : UIColor.systemOrange.withAlphaComponent(0.2)
            }
          
        case .genre:
            categoryView.bgView.backgroundColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.systemIndigo.withAlphaComponent(0.6) : UIColor.systemBlue.withAlphaComponent(0.1)
            }
        case .director:
            categoryView.bgView.backgroundColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.systemGreen.withAlphaComponent(0.6) : UIColor.systemGreen.withAlphaComponent(0.1)
            }
        case .actor:
            categoryView.bgView.backgroundColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.systemGray5 : UIColor.systemGray6
            }
        case .allMovies:
            categoryView.bgView.backgroundColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.systemFill.withAlphaComponent(0.6) : UIColor.systemPurple.withAlphaComponent(0.1)
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeader(_:)))
        categoryView.addGestureRecognizer(tapGesture)
        categoryView.tag = section
        return categoryView
    }




    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.isSearching ? 0 : 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.items[indexPath.section]
        return item.type == .allMovies ? 200 : 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie: Movie?
        
        if viewModel.isSearching {
            /// If searching, get the movie directly from the filteredMovies array
            selectedMovie = viewModel.filteredMovies[indexPath.row]
        } else {
            /// If not searching, determine the section type and filter accordingly
            let item = viewModel.items[indexPath.section]
            
            switch item.type {
            case .year:
                if let yearItem = item as? MovieViewModelYearItem {
                    let selectedYear = yearItem.years[indexPath.row]
                    let filteredMovies = viewModel.fetchMoviesByYear(year: selectedYear)
                    navigateToMovieList(with: filteredMovies, title: "\(AppStrings.ByTitles.moviesFrom) \(selectedYear)")
                }
            case .genre:
                if let genreItem = item as? MovieViewModelGenreItem {
                    let selectedGenre = genreItem.genres[indexPath.row]
                    let filteredMovies = viewModel.fetchMoviesByGenre(genre: selectedGenre)
                    navigateToMovieList(with: filteredMovies, title: "\(AppStrings.ByTitles.moviesIn) \(selectedGenre)")
                }
            case .director:
                if let directorItem = item as? MovieViewModelDirectorItem {
                    let selectedDirector = directorItem.directors[indexPath.row]
                    let filteredMovies = viewModel.fetchMoviesByDirector(director: selectedDirector)
                    navigateToMovieList(with: filteredMovies, title: "\(AppStrings.ByTitles.moviesBy) \(selectedDirector)")
                }
            case .actor:
                if let actorItem = item as? MovieViewModelActorItem {
                    let selectedActor = actorItem.actors[indexPath.row]
                    let filteredMovies = viewModel.fetchMoviesByActor(actor: selectedActor)
                    navigateToMovieList(with: filteredMovies, title: "\(AppStrings.ByTitles.moviesWith) \(selectedActor)")
                }
            case .allMovies:
                if let allMoviesItem = item as? MovieViewModelAllMoviesItem {
                    selectedMovie = allMoviesItem.movies[indexPath.row]
                    guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: AppIdentifiers.ViewControllerIdentifiers.movieDetailsVC) as? MovieDetailsViewController else {
                        return
                    }
                    detailsVC.movie = selectedMovie
                    navigationController?.pushViewController(detailsVC, animated: true)
                }
            }
        }
    }
}

extension HomeViewController {

    @objc func didTapHeader(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        viewModel.items[section].isCollapsed.toggle()
        
        /// Reload the section to update the UI
        homeTableView.reloadSections(IndexSet(integer: section), with: .automatic)
        
        /// Ensure layout is updated
        homeTableView.layoutIfNeeded()
        homeTableView.layoutSubviews()
    }
}

extension HomeViewController {
    private func navigateToMovieList(with movies: [Movie], title: String) {
        guard let movieListVC = storyboard?.instantiateViewController(withIdentifier: AppIdentifiers.ViewControllerIdentifiers.movieListVC) as? MovieListViewController else {
            return
        }
        movieListVC.movies = movies
        movieListVC.title = title
        navigationController?.pushViewController(movieListVC, animated: true)
    }
}
