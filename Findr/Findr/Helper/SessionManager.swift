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
    
    let db = Firestore.firestore()
    
    var movies = [Movie]()
    var foods = [Food]()
   
    
    func getMovieSession(key: String, completion: @escaping (MovieSession) -> ()) {
        var myMovies = [Movie]()
        db.collection("sessions").document(key).collection("cards").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    if let name = document.data()["title"] as? String {
                        let foodss = Movie(title: document.data()["title"] as! String, image: document.data()["image"] as! String, id: document.data()["id"] as! String, genre: document.data()["genre"] as! [Int], description: document.data()["description"] as! String, imdbScore: document.data()["imdbScore"] as! Float, trailerLink: document.data()["trailerLink"] as! String)
                        myMovies.append(foodss)
                    }
                }
                let sesh = MovieSession(User1: "", User2: "", kind: .both, genre: .any, key: key, movies: myMovies)
                completion(sesh)
            }
        }
    }
    
    
    
    func getFoodSession(key: String, completion: @escaping (FoodSession) -> ()) {
        var myMovies = [Food]()
        db.collection("sessions").document(key).collection("cards").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    if let name = document.data()["image"] as? String {
                        let foodss = Food(name: name, image: document.data()["image"] as! String, type: document.data()["type"] as! String, distance: document.data()["distance"] as! Double, reviewScore: document.data()["reviewScore"] as! Double, gmapsLink: document.data()["gmapsLink"] as! String, priceRange: document.data()["priceRange"] as! Int)
                        myMovies.append(foodss)
                    }
                }
                let sesh = FoodSession(User1: "", User2: "", priceRange: .any, minRating: .any, key: key, foods: myMovies)
                completion(sesh)
            }
        }
    }
    
    func startMovieSession(genre: movieGenre, kind: movieKind, completion: @escaping (MovieSession?) -> ()) {
        
        self.getAllMovies(completion: { [self] foods in
            
            let key = self.randomString(length: 6)
            self.db.collection("sessions").document(key).setData([
                "key": key,
                "users": ["user1", "user2"],
                "kind": "movie",
                "genre": genre.rawValue,
                "movieKind": kind.rawValue
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    
                }
            }
            
            var newMovie = [Movie]()
            
            for i in movies {
                if genre == .any {
                    newMovie.append(i)
                    
                } else {
                    var temp = 0
                    switch genre {
                    case .action:
                        temp = 5
                    case .comedy:
                        temp = 9
                    case .horror:
                        temp = 19
                    case .romance:
                        temp = 4
                    default:
                        temp = 9
                    }
                    
                    if i.genre.contains(temp) {
                        newMovie.append(i)
                    }
                }
            }
            
            let finalArray = newMovie.choose(50)
            
            var newArray: [Movie] = []
            
            
            for i in finalArray {
                newArray.append(i)
                self.db.collection("sessions").document(key).collection("cards").document(i.id).setData([
                    "title": i.title,
                    "image": i.image,
                    "id": i.id,
                    "genre": i.genre,
                    "description": i.description,
                    "imdbScore": i.imdbScore,
                    "trailerLink": i.trailerLink,
                    "user1Swiped": false,
                    "user2Swiped": false
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        
                    }
                }
            }
            let sesh = MovieSession(User1: "", User2: "", kind: kind, genre: genre, key: key, movies: newArray)
            completion(sesh)
            
        })
    }
    
    func startFoodSession(rating: MinRating, range: PriceRange, completion: @escaping (FoodSession?) -> ()) {
        
        self.getAllFood(completion: { foods in
            
            let key = self.randomString(length: 6)
            self.db.collection("sessions").document(key).setData([
                "key": key,
                "users": ["user1", "user2"],
                "kind": "food",
                "priceRange": range.rawValue,
                "rating": rating.rawValue
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                   
                }
            }
            
            var newFood = [Food]()
            
            if rating != .any || range != .any {
                for i in foods {
                    let tempRating = self.ratingToInt(rating: rating)
                    let tempRange = self.rangeToInt(range: range)
                    
                    if i.reviewScore >= Double(tempRating) && i.priceRange <= tempRange {
                        
                        newFood.append(i)
                        
                        let newName = String(i.distance) + "-" + i.name.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: " ", with: "")
                        
                        self.db.collection("sessions").document(key).collection("cards").document(newName).setData([
                            "name": i.name,
                            "image": i.image,
                            "type": i.type,
                            "distance": i.distance,
                            "reviewScore": i.reviewScore,
                            "gmapsLink": i.gmapsLink,
                            "priceRange": i.priceRange,
                            "user1Swiped": false,
                            "user2Swiped": false
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                
                            }
                        }
                    }
                }
            } else {
                newFood = foods
                
                for i in newFood {
                    let newName = String(i.distance) + "-" + i.name.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: " ", with: "")
                    self.db.collection("sessions").document(key).collection("cards").document(newName).setData([
                        "name": i.name,
                        "image": i.image,
                        "type": i.type,
                        "distance": i.distance,
                        "reviewScore": i.reviewScore,
                        "gmapsLink": i.gmapsLink,
                        "priceRange": i.priceRange,
                        "user1Swiped": false,
                        "user2Swiped": false
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            
                        }
                    }
                }
            }
            let sesh = FoodSession(User1: "", User2: "", priceRange: range, minRating: rating, key: key, foods: newFood)
            completion(sesh)
        })
    }
    
    func rangeToInt(range: PriceRange) -> Int {
        switch range {
        case .three:
            return 3
        case .two:
            return 2
        case .one:
            return 1
        case .any:
            return 0
        default:
            return 0
        }
    }
    
    func ratingToInt(rating: MinRating) -> Int {
        switch rating {
        case .four:
            return 4
        case .three:
            return 3
        case .any:
            return 0
        default:
            return 0
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".uppercased()
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func getAllFood(completion: @escaping ([Food]) -> ()) {
        foods.removeAll()
        db.collection("restaurants").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    if let name = document.data()["name"] as? String {
                        let foodss = Food(name: name, image: document.data()["image"] as! String, type: document.data()["type"] as! String, distance: document.data()["distance"] as! Double, reviewScore: document.data()["reviewScore"] as! Double, gmapsLink: document.data()["gmapsLink"] as! String, priceRange: document.data()["priceRange"] as! Int)
                        foods.append(foodss)
                    }
                }
                completion(foods)
            }
        }
    }
    
    func getAllMovies(completion: @escaping ([Movie]) -> ()) {
        movies.removeAll()
        db.collection("movies").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    if let id = document.data()["id"] as? String {
                        let newMovie = Movie(title: document.data()["title"] as! String, image: document.data()["image"] as! String, id: id, genre: document.data()["genre"] as! [Int], description: document.data()["description"] as! String, imdbScore: document.data()["imdbScore"] as! Float, trailerLink: document.data()["trailerLink"] as! String)
                        
                        movies.append(newMovie)
                    }
                }
                completion(movies)
            }
        }
    }
    
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
