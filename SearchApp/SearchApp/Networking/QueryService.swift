//
//  QueryService.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation

// Runs query data task, and stores results in array of Pages
class QueryService {

  typealias JSONDictionary = [String: Any]
  typealias QueryResult = ([Page]?, String) -> ()

  let defaultSession = URLSession(configuration: .default)

  var dataTask: URLSessionDataTask?
  var pages: [Page] = []
  var errorMessage = ""

  func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
    
    dataTask?.cancel()
    
    if var urlComponents = URLComponents(string: "https://en.wikipedia.org/w/api.php") {
      urlComponents.query = "action=query&generator=search&gsrlimit=20&gsroffset=\(pages.count)&gsrsearch=\(searchTerm)&utf8=&format=json&prop=info|pageimages&inprop=url"
      
      guard let url = urlComponents.url else { return }
      
      dataTask = defaultSession.dataTask(with: url) { data, response, error in
        defer { self.dataTask = nil }
        
        if let error = error {
          self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
        } else if let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          self.updateSearchResults(data)
          
          DispatchQueue.main.async {
            completion(self.pages, self.errorMessage)
          }
        }
      }
      
      dataTask?.resume()
    }
  }

  fileprivate func updateSearchResults(_ data: Data) {
    var response: JSONDictionary?
    pages.removeAll()

    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
      errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
      return
    }

    guard let pages = (response!["query"] as? [String : Any])?["pages"] as? [String : Any] else {
      errorMessage += "Dictionary does not contain query key\n"
      return
    }
    for pageDictionary in pages {
        if let pageDictionary = pageDictionary.value as? JSONDictionary,
            let title = pageDictionary["title"] as? String,
            let imageUrlString = (pageDictionary["thumbnail"] as? [String : Any])?["source"] as? String,
            let pageId = pageDictionary["pageid"] as? Int,
            let imageUrl = URL(string: imageUrlString),
            let pageUrlString = pageDictionary["fullurl"] as? String,
            let pageUrl = URL(string: pageUrlString)
         {
        self.pages.append(Page(title: title, pageId: pageId, pageUrl: pageUrl, imageUrl: imageUrl))
      } else {
        errorMessage += "Problem parsing pageDictionary\n"
      }
    }
  }

}
