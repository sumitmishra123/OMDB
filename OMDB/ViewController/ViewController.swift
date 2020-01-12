//
//  ViewController.swift
//  OMDB
//
//  Created by Zappfresh on 12/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    lazy var viewModel: OMDBViewModel = {
        return OMDBViewModel()
    }()
    
    var currentPage: Int = 1
    var totalPages: Int!
    var totalElement: Int!
    var movieName: String? = ""
    var omdbDataArray: [Search]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resizingCell()
        registerNIB()
        makeApiCall()
        initVM()
    }
    
    func resizingCell(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width/2  , height: 350)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 8.0
        collectionView!.collectionViewLayout = layout
    }
    
    func makeApiCall(){
        viewModel.getOMDBData(pageNumber: "\(currentPage)", movieName: movieName!)
    }
    
    func initVM(){
        viewModel.omdbPageRes = {
            success in
            self.fetchDataForList(data: success)
        }
    }
    
    func fetchDataForList(data: [Search]){
        totalElement = Int(viewModel.totalResult!)
        
        totalPages = Int(ceil(Float(totalElement) / 10))
        
        if(omdbDataArray!.count == 0){
            omdbDataArray = data
        }else{
            for i in data{
                omdbDataArray?.append(i)
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func registerNIB(){
        let nib = UINib(nibName: "OMDBCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "OMDBCollectionViewCell")
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return omdbDataArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OMDBCollectionViewCell", for: indexPath) as! OMDBCollectionViewCell
        cell.updateData(model: omdbDataArray![indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        nextView?.dataForItems = omdbDataArray![indexPath.row]
        self.navigationController?.pushViewController(nextView!, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row  == (omdbDataArray!.count - 1) {
            fetchNextPage()
        }
    }
    
    func fetchNextPage(){
        if(totalPages > currentPage){
            currentPage += 1
            viewModel.getOMDBData(pageNumber: "\(currentPage)", movieName: movieName!)
        }
    }
}

