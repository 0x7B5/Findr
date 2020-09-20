//
//  AppDelegate.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import UIKit
import Firebase
import CoreLocation


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        clearLaunchScreenCache()
        
        let mainVC = InitialVC()
        self.window?.rootViewController = mainVC
        
        var movies = [Movie]()
        
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
        //        for i in 0...6000 {
        //            SessionManager.shared.pullNewMovies(genre: "", number: 0, completion: { yuh in
        //                if let title = yuh["title"] as? String, let id = yuh["id"] as? String, let description = yuh["overview"] as? String, let rating = yuh["imdb_rating"] as? Float, let genres = yuh["genres"] as? [Int] {
        //
        //                    let newMov = Movie(title: title, image: "https://img.reelgood.com/content/show/\(id)/poster-780.jpg", id: id, genre: genres, description: description, imdbScore: rating, trailerLink: "")
        //                    movies.append(newMov)
        //                    print(newMov)
        //                    print(movies.count)
        //                    print("")
        //
        //                    db.collection("movies").document(id).setData([
        //                        "title": title,
        //                        "image": "https://img.reelgood.com/content/show/\(id)/poster-780.jpg",
        //                        "id": id,
        //                        "genre": genres,
        //                        "description": description,
        //                        "imdbScore": rating,
        //                        "trailerLink": ""
        //                    ]) { err in
        //                        if let err = err {
        //                            print("Error writing document: \(err)")
        //                        } else {
        //                            print("Document successfully written!")
        //                        }
        //                    }
        //
        ////                    SessionManager.shared.getTrailer(id: id, completion: {
        ////                        hey in
        ////
        ////                        if let trailerR = hey["trailer"] as? [String:Any] {
        ////                            if let site = trailerR["site"] as? String, let key = trailerR["key"] as? String{
        ////                                if site == "youtube" {
        ////                                    let newMov = Movie(title: title, Image: "https://img.reelgood.com/content/show/\(id)/poster-780.jpg", id: id, genre: genres, description: description, imdbScore: rating, trailerLink: "https://www.youtube.com/watch?v=\(key)")
        ////                                    movies.append(newMov)
        ////                                    print(newMov)
        ////                                    print(movies.count)
        ////                                    print("")
        ////                                }
        ////                            }
        ////                        }
        ////
        ////
        ////
        ////                    })
        //
        //                }
        //            })
        //        }
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

