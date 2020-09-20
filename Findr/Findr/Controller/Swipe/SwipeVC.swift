//
//  SwipeVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/19/20.
//

import PopBounceButton
import Shuffle_iOS
import SnapKit

class SwipeVC: UIViewController {
    
    var movieSesh: MovieSession = MovieSession(User1: "", User2: "", kind: .both, genre: .any, key: "", movies: [])
    
    var foodSesh: FoodSession = FoodSession(User1: "", User2: "", priceRange: .any, minRating: .any, key: "", foods: [])
    
    var myType: sessionType = .food
    private let cardStack = SwipeCardStack()
    
    private let buttonStackView = ButtonStackView()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        return view
    }()
    
    public let xButton: CurvedButton = {
        let button = CurvedButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.light)
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
    
    private let cardModels = [
        FindrCardModel(name: "Michelle",
                       age: 26,
                       occupation: "Graphic Designer",
                       image: UIImage(named: "michelle")),
        FindrCardModel(name: "Joshua",
                       age: 27,
                       occupation: "Business Services Sales Representative",
                       image: UIImage(named: "joshua")),
        FindrCardModel(name: "Daiane",
                       age: 23,
                       occupation: "Graduate Student",
                       image: UIImage(named: "daiane")),
        FindrCardModel(name: "Julian",
                       age: 25,
                       occupation: "Model/Photographer",
                       image: UIImage(named: "julian")),
        FindrCardModel(name: "Andrew",
                       age: 26,
                       occupation: nil,
                       image: UIImage(named: "andrew")),
        FindrCardModel(name: "Bailey",
                       age: 25,
                       occupation: "Software Engineer",
                       image: UIImage(named: "bailey")),
        FindrCardModel(name: "Rachel",
                       age: 27,
                       occupation: "Interior Designer",
                       image: UIImage(named: "rachel"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardStack.delegate = self
        cardStack.dataSource = self
        buttonStackView.delegate = self
        
        layoutButtonStackView()
        layoutCardStackView()
//        configureBackgroundGradient()
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
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
        
        let model = cardModels[index]
        card.content = FindrCardContentView(withImage: model.image)
//        card.footer = FindrCardContentView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupation)
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardModels.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Undo \(direction) swipe on \(cardModels[index].name)")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(cardModels[index].name)")
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
