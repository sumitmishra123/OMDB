//
//  OMDBViewModel.swift
//  OMDB
//
//  Created by Zappfresh on 12/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class OMDBViewModel: NSObject {
    var totalResult: String? = ""
    var omdbPageRes:(([Search])->())?
    func getOMDBData(pageNumber: String,movieName: String){
        ApiCall.getOMDBPageData(page: pageNumber, movieName: movieName,success: {
            data in
            let omdbPageModel = DataParser.parseOMBDData(data!)
            let res: [Search] = omdbPageModel!.search
            self.totalResult = omdbPageModel?.totalResults
            self.omdbPageRes!((res))
            print("Success")
        }) { (error, data, code)  in
            print("failure")
        }
    }
}

class DataParser{
    static func parseOMBDData(_ data: Data) -> OMDBModel? {
        do {
        let oMDBModel = try JSONDecoder().decode(OMDBModel.self, from: data)
        print(oMDBModel)
        return oMDBModel
        } catch {
        print(error)
        }
        return nil
    }
}
