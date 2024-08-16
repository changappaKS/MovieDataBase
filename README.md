# MovieDataBase
Movie Database APP

Movie Database is a simple application that displays a list of movies categorized by year, director, actor, and genre. It includes functionality to search through the list of movies and provides detailed information about each movie.

This iOS app allows users to browse and search for movies by various categories such as year, genre, director, and actors. The app is built using the MVVM architecture and displays detailed movie information, including ratings from different sources.

Features

Browse Movies by Categories: Filter movies by year, genre, directors, and actors.
Search Functionality: Search for movies by title, genre, actor, or director.
Expandable List: Expand and collapse cells to view details under each category.
All Movies List: Display a comprehensive list of all movies with thumbnails, titles, languages, and years.
Movie Details View: View detailed information about a movie, including the poster, plot, cast & crew, release date, genre, and ratings.
Custom Rating UI: View ratings from different sources (IMDB, Rotten Tomatoes, Metacritic) using a custom UI control.
Dynamic Data Loading: Load movie data dynamically based on user interactions.

Architecture

The app is designed using the MVVM (Model-View-ViewModel) architecture to ensure separation of concerns, easier testing, and a more maintainable codebase.

Components:

Model: Represents the movie data parsed from movies.json.
ViewModel: Acts as an intermediary between the view and the model, handling business logic and preparing data for the view.
View: Represents the UI components (e.g., UITableView, UICollectionView) that display the data.
Requirements

Xcode 14.0 or later
iOS 15.0 or later
Swift 5.5 or later

Installation

Clone the Repository:

git clone https://github.com/changappaKS/MovieDataBase.git
cd movie-database-app
Open in Xcode:

Open the .xcodeproj file in Xcode.

Run the App:

Select the target device or simulator and press Cmd + R to build and run the app.
Usage

Browsing Movies

On the main screen, tap on any category (Year, Genre, Directors, Actors, All Movies) to expand the list and see related values.
Tapping on a specific value (e.g., a genre or year) will show a list of movies associated with that value.
Searching for Movies

Use the search bar at the top to search for movies by title, genre, actor, or director.
The search results will display movies that match the search criteria.
Clear the search to return to the main browsing screen.
Viewing Movie Details

Tap on any movie in the list to view detailed information about the movie.
Switch between different rating sources (IMDB, Rotten Tomatoes, Metacritic) to see the respective rating.
