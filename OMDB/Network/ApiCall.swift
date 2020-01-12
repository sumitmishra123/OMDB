//
//  ApiCall.swift


import Alamofire
//import CommonLib

open class ApiCall {
  
  /// Authenticate User.
  
  /// - parameters:
  ///   - pageTitleParam: username as `String`.
  ///   - success: success closure `SuccessClosure` parameter.
  ///   - failure: failure closure as `FailureClosure` parameter.
  /// - returns: `Request` object.
  @discardableResult
    public static func getOMDBPageData(page:String,movieName: String,success: @escaping SuccessClosure, failure: @escaping FailureClosure) -> Request {

    let baseUrl = "http://www.omdbapi.com/?s="
    let url = baseUrl + movieName + "&page=" + page + "&apikey=eeefc96f"
    let requestParameter = RequestParameter.createRequestParameter(url, method: .get, parameters: nil)
    return NetworkManagerWrapper.makeRequest(requestParameter, encoding: URLEncoding.httpBody, success: success, failure: failure)
  }
}
