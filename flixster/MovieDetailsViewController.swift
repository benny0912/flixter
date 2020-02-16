//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Benny Ooi Kean Hoe on 2/15/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: [String: Any]!
    let imgBaseUrl = "https://image.tmdb.org/t/p/"
    let imgSize = "w185"
    let backdropSize = "w780"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let imgPath = movie["poster_path"] as! String
        let imgUrlStr = "\(imgBaseUrl)/\(imgSize)\(imgPath)"
        let imgUrl = URL(string: imgUrlStr)!
        posterView.af_setImage(withURL: imgUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrlStr = "\(imgBaseUrl)/\(backdropSize)\(backdropPath)"
        let backdropUrl = URL(string: backdropUrlStr)!
        backdropView.af_setImage(withURL: backdropUrl)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
