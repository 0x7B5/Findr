//
//  SessionManager.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/19/20.
//

import Foundation
import UIKit
import CoreLocation
import Firebase

public class SessionManager {
    static let shared = SessionManager()
    
    private init() { }
    
    
    func pullNewMovies(genre: String, number: Int, completion: @escaping ([String: Any]) -> ()) {
        if let url = URL(string: "https://api.reelgood.com/v3.0/content/roulette/netflix?availability=onAnySource&content_kind=both&nocache=true&region=us") {
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print(err ?? "Error")
                    completion([" ": " "])
                }
                guard let data = data else { return }
                
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(json)
                    }
                } catch _ {
                    completion([" ": " "])
                }
            }.resume()
        }
    }
    
    func pullNewPlaces(token: String, completion: @escaping ([String: Any]) -> ()) {
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/search/json?location=37.227391,-80.438232&radius=10000&types=resturant&hasNextPage=true&nextPage()=true&sensor=false&key=\(Constants.gmapsAPIKey)&pagetoken=\(token)") {
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print(err ?? "Error")
                    completion([" ": " "])
                }
                guard let data = data else { return }
                
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(json)
                    }
                } catch _ {
                    completion([" ": " "])
                }
            }.resume()
        }
    }
    
    func getTrailer(id: String, completion: @escaping ([String: Any]) -> ()) {
        if let url = URL(string: "https://api.reelgood.com/v3.0/content/show/\(id)?availability=onAnySource&interaction=true&region=us") {
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print(err ?? "Error")
                    completion([" ": " "])
                }
                guard let data = data else { return }
                
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(json)
                    }
                } catch _ {
                    completion([" ": " "])
                }
            }.resume()
        }
    }
    
    
    func parseGMapsResults(json: [String:Any]) -> [Food]{
        var nextToken = ""
        let db = Firestore.firestore()
        var foods = [Food]()
        if let results = json["results"] as? [[String: Any]] {
            
            
            for i in results {
                
                if let geo = i["geometry"] as? [String: Any], let name = i["name"] as? String, let rating = i["rating"] as? Double, let priceRange = i["price_level"] as? Int, let photos = i["photos"] as? [[String: Any]], let id = i["place_id"] as? String {
                    if let location = geo["location"] as? [String: Any], let reference = photos[0]["photo_reference"] as? String {
                        
                        let lat = location["lat"] as! Double
                        let lng = location["lng"] as! Double
                        
                        
                        let coordinate0 = CLLocation(latitude: 37.227391, longitude: -80.438232)
                        let coordinate1 = CLLocation(latitude: lat, longitude: lng)
                        
                        let dist = coordinate0.distance(from: coordinate1)/1609.0
                        
                        let myFood = Food(name: name, image: "https://maps.googleapis.com/maps/api/place/photo?photoreference=\(reference)&sensor=false&maxheight=1323&maxwidth=1909&key=\(Constants.gmapsAPIKey)", type: "", distance: dist, reviewScore: rating, gmapsLink: "https://www.google.com/maps/place/?q=place_id:\(id)", priceRange: priceRange)
                        
                        db.collection("restaurants").document(id).setData([
                            "name": name,
                            "image": "https://maps.googleapis.com/maps/api/place/photo?photoreference=\(reference)&sensor=false&maxheight=1323&maxwidth=1909&key=\(Constants.gmapsAPIKey)",
                            "type": "",
                            "distance": dist,
                            "reviewScore": rating,
                            "gmapsLink": "https://www.google.com/maps/place/?q=place_id:\(id)",
                            "priceRange": priceRange
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        print(myFood)
                        print("")
                        foods.append(myFood)
                        
                        
                    }
                }
            }
        }
        return foods
    }
    
    
    
    
    
    
    
    
}
