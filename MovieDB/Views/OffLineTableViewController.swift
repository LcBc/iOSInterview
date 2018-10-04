//
//  OffLineTableViewController.swift
//  MovieDB
//
//  Created by Luis Barrios on 10/2/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import UIKit

class OffLineTableViewController: OnLineTableTableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var offlineSearch: UISearchBar!
    var isFiltering: Bool = false

    var filteredMovies:[Movie]?{
            didSet{
                tableView.reloadData()
            }
    }
    
    override var cellIdentifier: String{
        get{
            return "offlineCell"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offlineSearch.delegate = self
    }
    
    
    
    override func fetchMovies(in category: Category) {
        print(category)
        if  let context = AppDelegate.getPersistentContainer()?.viewContext {
            movies = MovieRepository.fetchAll(in: category, inManagedObjectContext: context)
//            print(movies)
//            movies?.forEach{
//                print($0)
//            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isFiltering = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredMovies = movies?.filter{
            $0.title?.range(of: searchText, options: .caseInsensitive) != nil
        }
        
        if(filteredMovies?.count == 0){
            isFiltering = false
        }else{
            isFiltering = true
        }
        
        self.tableView.reloadData()
      //  self.tableView.reloadSections(IndexSet(integersIn: 0...0), with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies?.count ?? 0
        }
        return movies?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath)
            
            if let cell = cell as? MovieTableViewCell{
                
                if isFiltering{
                    cell.movie = filteredMovies?[indexPath.row]
                }else{
                    cell.movie = movies?[indexPath.row]
                }
                
            }
            return cell
        
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifier,
            let index = sender as? Int,
            let destination = segue.destination as? DetailViewController {
            if isFiltering{
                
                destination.movie = filteredMovies?[index]
            }else{
              destination.movie = movies?[index]
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}
