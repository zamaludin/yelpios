//
//  PlacesNetwork.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 29/05/22.
//

import Foundation
struct PlacesNetwork {
        
    static func getBusinessesList( parameters : [String : String],
                      onSuccess:@escaping (_ response: DAOPlaceList) -> Void,
                      onFailure:@escaping (_ response: String) -> Void) {
        
        var url = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        var items = [URLQueryItem]()
        let _ = parameters.map {
            items.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        url.queryItems = items
        var request = URLRequest(url: url.url!)
        request.setValue("Bearer u3gyyn5AEr34npYqGu2Px5QqLH97Sx5SHXFNJRjm7S3Xz3LxaSw-jvprRDhVy0s8eslmxRry2iCClxwx7-thoeFL1qM3Tc8ju-15XcccfdO4EnALdxWdbnFbMn2RYnYx",
                         forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let places = try JSONDecoder().decode(DAOPlaceList.self, from: data)
                    onSuccess(places)
                } catch {
                    print(error)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                onFailure("\(error)")
            }
        }
        task.resume()
    }
    
    static func getBusinessesDetail(id : String,
                      onSuccess:@escaping (_ response: DAOPlaceDetail) -> Void,
                      onFailure:@escaping (_ response: String) -> Void) {
        
        let url = URLComponents(string: "https://api.yelp.com/v3/businesses/\(id)")!
        var request = URLRequest(url: url.url!)
        request.setValue("Bearer u3gyyn5AEr34npYqGu2Px5QqLH97Sx5SHXFNJRjm7S3Xz3LxaSw-jvprRDhVy0s8eslmxRry2iCClxwx7-thoeFL1qM3Tc8ju-15XcccfdO4EnALdxWdbnFbMn2RYnYx",
                         forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           
            
            if let data = data {
                print(request.url?.absoluteString)
                print("JSON String: \(String(data: data, encoding: .utf8))")
                
                do {
                    let places = try JSONDecoder().decode(DAOPlaceDetail.self, from: data)
                    onSuccess(places)
                } catch {
                    print(error)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                onFailure("\(error)")
            }
        }
        task.resume()
    }
}
