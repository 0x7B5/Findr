//
//  ButtonStackView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/20/20.
//

import PopBounceButton

protocol ButtonStackViewDelegate: AnyObject {
  func didTapButton(button: FindrButton)
}

class ButtonStackView: UIStackView {

  weak var delegate: ButtonStackViewDelegate?

  private let undoButton: FindrButton = {
    let button = FindrButton()
    button.setImage(UIImage(named: "undo"), for: .normal)
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    button.tag = 1
    return button
  }()

  private let passButton: FindrButton = {
    let button = FindrButton()
    button.setTitle("X", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    button.tag = 2
    return button
  }()

  private let likeButton: FindrButton = {
    let button = FindrButton()
    button.setTitle("♡", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
    
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    button.tag = 4
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    distribution = .equalSpacing
    alignment = .center
    configureButtons()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureButtons() {
    let largeMultiplier: CGFloat = 100 / 414 //based on width of iPhone 8+
    let smallMultiplier: CGFloat = 54 / 414 //based on width of iPhone 8+
    addArrangedSubview(from: passButton, diameterMultiplier: largeMultiplier)
    addArrangedSubview(from: likeButton, diameterMultiplier: largeMultiplier)
    
  }

  private func addArrangedSubview(from button: FindrButton, diameterMultiplier: CGFloat) {
    let container = ButtonContainer()
    container.addSubview(button)
    button.anchorToSuperview()
    addArrangedSubview(container)
    container.translatesAutoresizingMaskIntoConstraints = false
    container.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: diameterMultiplier).isActive = true
    container.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
  }

  @objc
  private func handleTap(_ button: FindrButton) {
    delegate?.didTapButton(button: button)
  }
}

private class ButtonContainer: UIView {

  override func draw(_ rect: CGRect) {
    applyShadow(radius: 0.2 * bounds.width, opacity: 0.05, offset: CGSize(width: 0, height: 0.15 * bounds.width))
  }
}
