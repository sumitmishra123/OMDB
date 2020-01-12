//
//  OMDBCollectionViewCell.swift
//  OMDB
//
//  Created by Zappfresh on 12/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import SDWebImage
class OMDBCollectionViewCell: UICollectionViewCell {

    @IBOutlet var yearAgo: UILabel!
    @IBOutlet var posterView: UIImageView!
    @IBOutlet var releaseYear: UILabel!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var typeMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateData(model: Search){
        self.releaseYear.text = model.year
        self.yearAgo.text = "Released " + "\(self.getCurrentDate(year: model.year))" + " years ago."
        self.movieTitle.text = model.title
        self.typeMovie.text = model.type
        self.posterView.sd_setImage(with: URL(string: model.poster), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    func getCurrentDate(year: String) -> Int{
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        if(year.count > 4){
            let data: String = String(year.split(separator: "–")[0])
            let dateString = dateFormatter.string(from: date as Date)
            let timeAgo = Int(dateString)! - Int(data)!
            return timeAgo
        }else{
            let dateString = dateFormatter.string(from: date as Date)
            let timeAgo = Int(dateString)! - Int(year)!
            return timeAgo
        }
    }
}
