//
//  MovieListViewController.swift
//  MovieDataBase
//
//  Created by Changappa K S on 15/08/24.
//

// MARK: - Movie Listing Controller
import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieListTableView: UITableView!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    func setupTableView() {
        movieListTableView.register(UINib(nibName: AppIdentifiers.CellIdentifiers.moviesTVCell, bundle: nil),
                                    forCellReuseIdentifier: AppIdentifiers.CellIdentifiers.moviesTVCell)

        movieListTableView.dataSource = self
        movieListTableView.delegate = self

        movieListTableView.rowHeight = UITableView.automaticDimension
        movieListTableView.estimatedRowHeight = 200
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate methods
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.CellIdentifiers.moviesTVCell, for: indexPath) as? MoviesTVCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: AppIdentifiers.ViewControllerIdentifiers.movieDetailsVC) as? MovieDetailsViewController else {
            return
        }

        detailsVC.movie = selectedMovie
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}
