//
//  SwipeVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/19/20.
//

import PopBounceButton
import Shuffle_iOS
import SnapKit
import SDWebImage
import PopupDialog
import Firebase

class SwipeVC: UIViewController {
    
    let db = Firestore.firestore()
    var movieSesh: MovieSession = MovieSession(User1: "", User2: "", kind: .both, genre: .any, key: "", movies: [])
    var seshKey = ""
    var foodSesh: FoodSession = FoodSession(User1: "", User2: "", priceRange: .any, minRating: .any, key: "", foods: [])
    
    var myType: sessionType = .food
    var user1 = false
    private let cardStack = SwipeCardStack()
    
    private let buttonStackView = ButtonStackView()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        return view
    }()
    
    public let keyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.semibold)
        label.adjustsFontForContentSizeCategory = true
        label.text = "4HSMMZ"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    public let xButton: CurvedButton = {
        let button = CurvedButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        button.addTarget(self, action: #selector(exitOut), for: .touchUpInside)
        return button
    }()
    
    @objc func exitOut() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        
        let vc = DecideVC()
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(transition, forKey: nil)
        self.present(vc, animated: false)
    }
    
    private var cardModels = [FindrCardModel]()
    
    @objc func checkForMatch() {
        let docRef = db.collection("sessions").document(seshKey).collection("cards")
        
        docRef
            .whereField("user1Swiped", isEqualTo: true)
            .whereField("user2Swiped", isEqualTo: true)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let dataDescription = document.data() as? [String: Any] {
                            handleMatch(doc: dataDescription)
                        }
                    }
                }
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: Selector(("checkForMatch")), userInfo: nil, repeats: true)
        
        setupCardModels()
        
        if myType == .food {
            
            keyLabel.text = foodSesh.key
            seshKey = foodSesh.key
        } else {
            keyLabel.text = movieSesh.key
            seshKey = movieSesh.key
        }
        cardStack.delegate = self
        cardStack.dataSource = self
        buttonStackView.delegate = self
        
        layoutButtonStackView()
        layoutCardStackView()
        
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }
    
    func setupCardModels() {
        if myType == .movie {
            for i in movieSesh.movies {
                
                var genre = "Avaliable on Netflix"
                for x in i.genre {
                    if x == 5 {
                        genre = "Action"
                        break
                    } else if x == 9 {
                        genre = "Comedy"
                        break
                    } else if x == 19 {
                        genre = "Horror"
                        break
                    } else if x == 4 {
                        genre = "Romance"
                        break
                    }
                }
                
                cardModels.append(FindrCardModel(title: i.title, rating: Double(i.imdbScore), subtitle: genre, image: i.image, id: i.id))
            }
        } else {
            for i in foodSesh.foods {
                
                var rangeLabel = "$"
                
                if i.priceRange == 1 {
                    rangeLabel = "$"
                } else if i.priceRange == 2 {
                    rangeLabel = "$$"
                } else if i.priceRange == 3 {
                    rangeLabel = "$$$"
                } else if i.priceRange == 4 {
                    rangeLabel = "$$$$"
                }
                
                let newName = String(i.distance) + "-" + i.name.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: " ", with: "")
                
                cardModels.append(FindrCardModel(title: i.name, rating: Double(i.reviewScore), subtitle: rangeLabel, image: i.image, id: newName))
            }
        }
        cardModels = cardModels.sorted { $0.id < $1.id }
    }
    
    
    
    private func configureBackgroundGradient() {
        let backgroundGray = UIColor(red: 244 / 255, green: 247 / 255, blue: 250 / 255, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, backgroundGray.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func layoutButtonStackView() {
        view.addSubview(buttonStackView)
        
        buttonStackView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.safeAreaLayoutGuide.rightAnchor,
                               paddingLeft: 60,
                               paddingBottom: 5,
                               paddingRight: 60)
    }
    
    private func layoutCardStackView() {
        view.addSubview(topView)
        view.addSubview(cardStack)
        
        topView.addSubview(xButton)
        
        xButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalToSuperview()
            $0.centerX.equalToSuperview().multipliedBy(0.2)
            $0.top.equalToSuperview().inset(25)
        }
        
        topView.addSubview(keyLabel)
        
        keyLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.32)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(20)
        }
        
        topView.anchor(top: view.topAnchor,
                       left: view.safeAreaLayoutGuide.leftAnchor,
                       right: view.safeAreaLayoutGuide.rightAnchor,
                       height: 100)
        
        cardStack.anchor(top: topView.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: buttonStackView.topAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 20,
                         paddingLeft: 10, paddingBottom: 20,
                         paddingRight: 10
        )
    }
    
    @objc
    private func handleShift(_ sender: UIButton) {
        cardStack.shift(withDistance: sender.tag == 1 ? -1 : 1, animated: true)
    }
    
}

// MARK: Data Source + Delegates

extension SwipeVC: ButtonStackViewDelegate, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .right]
        for direction in card.swipeDirections {
            card.setOverlay(FindrCardOverlay(direction: direction), forDirection: direction)
        }
        
        
        if myType == .food {
            card.content = FindrCardContentView(withImage: cardModels[index].image, isFood: true)
        } else {
            card.content = FindrCardContentView(withImage: cardModels[index].image, isFood: false)
        }
        
        card.footer = FindrCardFooterView(withTitle: cardModels[index].title, subtitle:cardModels[index].subtitle, score: cardModels[index].rating)
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardModels.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Undo \(direction) swipe on \(cardModels[index].title)")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(cardModels[index].title)")
        
        let id = cardModels[index].id
        let docRef = db.collection("sessions").document(seshKey).collection("cards").document(id)
        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                if let dataDescription = document.data() as? [String: Any] {
                    if let user1Swiped = dataDescription["user1Swiped"] as? Bool, let user2Swiped = dataDescription["user2Swiped"] as? Bool {
                        if direction == .right {
                            if user1 {
                                docRef.updateData([
                                    "user1Swiped": true
                                ]) { err in
                                    if let err = err {
                                        print("Error updating document: \(err)")
                                    } else {
                                        print("Document successfully updated")
                                    }
                                }
                                if user2Swiped {
                                    handleMatch(doc: dataDescription)
                                }
                            } else {
                                docRef.updateData([
                                    "user2Swiped": true
                                ]) { err in
                                    if let err = err {
                                        print("Error updating document: \(err)")
                                    } else {
                                        print("Document successfully updated")
                                    }
                                }
                                
                                if user1Swiped {
                                    handleMatch(doc: dataDescription)
                                }
                            }
                            
                        }
                        
                    }
                }
                
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func handleMatch(doc: [String:Any]) {
        Timer.cancelPreviousPerformRequests(withTarget: self, selector: Selector(("checkForMatch")), object: nil)
        
        var message = ""
        var myImage = UIImage(named: "16")
        let imageView = UIImageView()
        let copy = doc["image"] as! String
        
        if myType == .food {
            let dist = (doc["distance"] as! Double).rounded(toPlaces: 2)
            message = "You and your partner matched on \(doc["name"] as! String)! Its only \(dist) miles away. Do you want to go to the google maps page?"
            imageView.sd_setImage(with: URL(string: copy)) { [self] (newImage, error, cache, urls) in
                if (error != nil) {
                    myImage = UIImage(named: "food")
                } else {
                    //Success code here
                    myImage = newImage
                }
            }
        } else {
            
            message = "You and your partner matched on \(doc["title"] as! String)! Do you want to open it in Netflix?"
        }
        let title = "Its a match!"
        
        
        // Create the dialog
        
        if myType == .movie {
            SessionManager.shared.getMoviePicture(copy: copy, completion: {
                myImg in
                let popup = PopupDialog(title: title, message: message, image: myImage)
                
                let buttonOne = DefaultButton(title: "No Thanks!", dismissOnTap: true) {
                    self.exitOut()
                }
                
                let buttonTwo = DefaultButton(title: "Let's Go!", dismissOnTap: true) { [self] in
                    
                    guard let url = URL(string: "https://www.netflix.com/watch/80134431?trackId=13752289&tctx=0%2C0%2Ce574628a2d268b9d31ca12d15bc776a83b39bf7b%3Af15f3087a4a2ee6aa111581739cf1aebf55ed4e6%2Ce574628a2d268b9d31ca12d15bc776a83b39bf7b%3Af15f3087a4a2ee6aa111581739cf1aebf55ed4e6%2C%2C") else { return }
                    UIApplication.shared.open(url)
                    self.exitOut()
                    
                }
                
                
                // Add buttons to dialog
                // Alternatively, you can use popup.addButton(buttonOne)
                // to add a single button
                popup.addButtons([buttonTwo, buttonOne])
                
                // Present dialog
                self.present(popup, animated: true, completion: nil)
            })
        } else {
            let popup = PopupDialog(title: title, message: message, image: myImage)
            
            let buttonOne = DefaultButton(title: "No Thanks!", dismissOnTap: true) {
                self.exitOut()
            }
            
            let buttonTwo = DefaultButton(title: "Let's Go!", dismissOnTap: true) { [self] in
                guard let url = URL(string: "https://www.google.com/maps?q=Subway,+Burke+Johnston+Student+Center,+G,+Blacksburg,+VA+24061&ftid=0x884d956cb4ad9ae7:0x48af140f2bd2388b&hl=en-US&gl=us&shorturl=1") else { return }
                UIApplication.shared.open(url)
                self.exitOut()
            }
            
            
            // Add buttons to dialog
            // Alternatively, you can use popup.addButton(buttonOne)
            // to add a single button
            popup.addButtons([buttonTwo, buttonOne])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
    }
    
    func didTapButton(button: FindrButton) {
        switch button.tag {
        case 1:
            //            cardStack.undoLastSwipe(animated: true)
            print("undo")
        case 2:
            cardStack.swipe(.left, animated: true)
        case 3:
            //            cardStack.swipe(.up, animated: true)
            print("up")
        case 4:
            cardStack.swipe(.right, animated: true)
        case 5:
            cardStack.reloadData()
        default:
            break
        }
    }
}
