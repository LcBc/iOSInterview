//
//  OfflineTableTableViewController.swift
//  MovieDB
//
//  Created by Luis Barrios on 10/2/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import UIKit

class OnLineTableTableViewController: UITableViewController {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var topRatedButton: UIButton!
    @IBOutlet weak var fastBackward: UIButton!
    @IBOutlet weak var backward: UIButton!
    @IBOutlet weak var foward: UIButton!
    @IBOutlet weak var fastFoward: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    
    
    //  var cellIdentifier: String {get {return "offlineCell"}}
    var cellIdentifier: String {get {return "movieCell"}}
    var segueIdentifier: String {get{return "detailSegue"}}
    
    var currentPage = 1
    var totalPages = 1
    var movies:[Movie]?{
        didSet{
             tableView.reloadData()
        }
    }
    
    var selectedCategory:Category{
        get{
            if popularButton.isSelected {
                return .popular
            }
            
            if upcomingButton.isSelected {
                return .upcoming
            }
            
            return .topRated
        }
    }
    
//    var filteredMovies:[Movie]?{
//        didSet{
//            tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onPopular()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView
//    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return headerView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies?.count ?? 0
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath)

        if let cell = cell as? MovieTableViewCell{
         cell.movie = movies?[indexPath.row]
        }
        return cell
    }

    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func fetchMovies(in category: Category){
        if  let context = AppDelegate.getPersistentContainer()?.viewContext {
            MovieRequestManager.fetchMovies(in: category,page: currentPage){[unowned self] in
                guard let result = $0 as? [String: Any] else{
                    return
                }
                if let currentPage = result["page"] as? Int {
                    self.currentPage = currentPage
                }
                if let totalPages = result["total_pages"] as? Int {
                    self.totalPages = totalPages
                }
                self.pageLabel.text = "\(self.currentPage)/ \(self.totalPages)"
                let rows = result["results"] as? [[String: Any]]
                self.movies =   rows?.compactMap{MovieRepository.parseAndUpdate(JSON: $0, inManagedObjectContext: context,with: category)}
            }
            try? context.save()
        }
   //     scrollToFirstRow()
        
    }
    
    
    
    
    
    
    @IBAction  func onPopular() {
//      loadPopularMovies()
      currentPage = 1
      fetchMovies(in: .popular)
      popularButton.isSelected = true
      upcomingButton.isSelected = false
      topRatedButton.isSelected = false
    }
    

    
    @IBAction  func onUpcoming() {
        currentPage = 1
        fetchMovies(in: .upcoming)
        popularButton.isSelected = false
        upcomingButton.isSelected = true
        topRatedButton.isSelected = false
    }
    
    @IBAction  func onTopRated() {
        currentPage = 1
        fetchMovies(in: .topRated)
        popularButton.isSelected = false
        upcomingButton.isSelected = false
        topRatedButton.isSelected = true
    }
    

    
    @IBAction func onFastBackward() {
        
        if currentPage <= 5 {
            currentPage = 1
        }
        if currentPage > 5 {
            currentPage -= 5
        }
        fetchMovies(in: selectedCategory)
        
        
    }
    
    @IBAction func onBackward() {
    
        if currentPage > 1 {
            currentPage  -= 1
        }
        fetchMovies(in: selectedCategory)
    
    }
    
    @IBAction func onFoward() {
        if currentPage < totalPages {
            currentPage += 1
        }
         fetchMovies(in: selectedCategory)
        
    }
    
    @IBAction func onFastFoward() {
        if currentPage <= totalPages {
            currentPage += 5
        }
        if currentPage > totalPages - 5 {
            currentPage = totalPages
        }
        fetchMovies(in: selectedCategory)
        
    }
    
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == segueIdentifier,
            let index = sender as? Int,
            let destination = segue.destination as? DetailViewController {
            destination.movie = movies?[index]
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
