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

class SwipeVC: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    let cardImages = [
          UIImage(named: "cardImage1"),
          UIImage(named: "cardImage2"),
          UIImage(named: "cardImage3")
      ]
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card(fromImage: cardImages[index]!)
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
      return cardImages.count
    }
    
    let cardStack = SwipeCardStack()
    
    func card(fromImage image: UIImage) -> SwipeCard {
      let card = SwipeCard()
      card.swipeDirections = [.left, .right]
      card.content = UIImageView(image: image)
      
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
        print("Swipe view did load")
        view.addSubview(cardStack)
        
        for i in cardImages {
            
        }
        
        
    }
    
    
    
    
    
}
