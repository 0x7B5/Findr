//
//  SwipeVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/19/20.
//

import Foundation
import UIKit
import SnapKit
import Shuffle_iOS
import SDWebImage

class SwipeVC: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    lazy var swipeView = SwipeView()
    unowned var bgView: UIView { return swipeView.bgView}
    
    override func loadView() {
        self.view = swipeView
        print("loadView")
    }
    
    var movieSesh: MovieSession = MovieSession(User1: "", User2: "", kind: .both, genre: .any, key: "", movies: [])
    
    var foodSesh: FoodSession = FoodSession(User1: "", User2: "", priceRange: .any, minRating: .any, key: "", foods: [])
    
    var myType: sessionType = .food
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        if (myType == .food) {
            return card(fromImage: foodSesh.foods[index].image)
        }
        return card(fromImage: movieSesh.movies[index].image)
        
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        if (myType == .food) {
            return foodSesh.foods.count
        }
        return movieSesh.movies.count
    }
    
    let cardStack = SwipeCardStack()
    
    func card(fromImage image: String) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
        
        let randImageView = UIImageView()
        
        if (myType == .food) {
            randImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "food"))
        } else {
            randImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "movie"))
        }
       
        
        
        card.content = randImageView
        
        let leftOverlay = UIView()
        leftOverlay.backgroundColor = .green
        
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = .red
        
        card.setOverlays([.left: leftOverlay, .right: rightOverlay])
        
        return card
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardStack.dataSource = self
        cardStack.dataSource = self
        print("Swipe view did load")
        bgView.addSubview(cardStack)
        
//        if (myType == .food) {
//            for i in movieSesh.movies {
//                card(fromImage: i.image)
//            }
//        } else {
//            for i in foodSesh.foods {
//                card(fromImage: i.image)
//            }
//        }
    }
    
    
    
    
    
}
