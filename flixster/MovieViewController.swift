//
//  ViewController.swift
//  flixster
//
//  Created by Benny Ooi Kean Hoe on 2/12/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movies = [[String:Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    let imgBaseUrl = "https://image.tmdb.org/t/p/"
    let imgSize = "w185"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        getMovie()
    }
    
    func getMovie() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            // TODO: Get the array of movies
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              // TODO: Store the movies in a property to use elsewhere
            self.movies = dataDictionary["results"] as! [[String: Any]]
              // TODO: Reload your table view data
            self.tableView.reloadData()

           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        let imgPath = movie["poster_path"] as! String
        
        let imgUrlStr = "\(imgBaseUrl)/\(imgSize)\(imgPath)"
        let imgUrl = URL(string: imgUrlStr)!
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        cell.posterView.af_setImage(withURL: imgUrl)
        
        return cell
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass selected movie detail to next view controller
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}

