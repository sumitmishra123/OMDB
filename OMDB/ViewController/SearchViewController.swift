//
//  SearchViewController.swift
//  OMDB
//
//  Created by Zappfresh on 12/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchMovie: UITextField!
    @IBOutlet var searchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBtn.layer.cornerRadius = 12.0
    }
    @IBAction func searchClick(_ sender: Any) {
        if(searchMovie.text == nil || searchMovie.text == ""){
            self.alert(message: "Please Enter movie name.")
        }else{
            let nextView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            nextView!.movieName = searchMovie.text
            self.navigationController?.pushViewController(nextView!, animated: true)
        }
    }
    
    func alert(message: String, title: String = "") {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    }
    
}
