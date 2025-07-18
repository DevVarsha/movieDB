import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate {
    let searchViewModel = SearchViewModel()
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    @IBOutlet weak var tabelView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.sectionHeaderTopPadding = 24
        searchViewModel.bind { state in
            switch state {
            case .initial:
                break
            case .loading:
                print("Loading")
            case .loaded:
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
        searchViewModel.loadGenres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchViewModel.loadRecentlyVisitedMovies()
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        searchViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        searchViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = searchViewModel.sections[indexPath.section]
        switch section {
        case .recentlyVisited(let recentMovies):
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewRecentCell.reuseIdentifier) as! SearchTableViewRecentCell
            cell.movies = recentMovies
            return cell
        case .movieGroups(let groups):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieGroupCell")!
            let group = groups[indexPath.row]
            cell.textLabel?.text = group.title
            cell.detailTextLabel?.text = group.subtitle
            cell.accessoryType = .disclosureIndicator
            return cell
        case .genres(let genres):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieGenreCell")!
            let genre = genres[indexPath.row]
            cell.textLabel?.text = genre.name
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        searchViewModel.titleForHeaderInSection(section: section)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SimilarAndPopularViewController") as? SimilarAndPopularViewController else {
            return
        }
        viewController.moviesViewModel.navigationBarTitle = indexPath.row == 0 ? "Popular Movies" :
        "Top Rated Movies"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
