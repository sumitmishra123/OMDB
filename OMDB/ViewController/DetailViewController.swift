//
//  DetailViewController.swift
//  OMDB
//
//  Created by Zappfresh on 12/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import SDWebImage
class DetailViewController: UIViewController {
    
    @IBOutlet var type: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var yearAgo: UILabel!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var posterImage: UIImageView!
    
    var dataForItems: Search?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Detail"
        setData()
    }
    func setData(){
        self.posterImage.sd_setImage(with: URL(string: dataForItems!.poster), placeholderImage: UIImage(named: "placeholder.png"))
        self.yearAgo.text = "Released " + "\(self.getCurrentDate())" + " years ago."
        self.type.text = "Type: " + (dataForItems?.type)!
        self.time.text = "Release Year: " + dataForItems!.year
        self.movieTitle.text = dataForItems?.title
    }
    
    func getCurrentDate() -> Int{
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        if((dataForItems?.year.contains("–"))!){
            let data: String = String((dataForItems?.year.split(separator: "–")[0])!)
            let dateString = dateFormatter.string(from: date as Date)
            let timeAgo = Int(dateString)! - Int(data)!
            return timeAgo
        }else{
            let dateString = dateFormatter.string(from: date as Date)
            let timeAgo = Int(dateString)! - Int(dataForItems!.year)!
            return timeAgo
        }
    }
}
