//
//  FindrButton.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/20/20.
//

import PopBounceButton

class FindrButton: PopBounceButton {

  override init() {
    super.init()
    adjustsImageWhenHighlighted = false
    backgroundColor = .white
    layer.masksToBounds = true
  }

  required init?(coder aDecoder: NSCoder) {
    return nil
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    layer.cornerRadius = frame.width / 2
  }
}
