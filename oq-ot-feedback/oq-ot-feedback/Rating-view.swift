//
//  ContentView.swift
//  oq-ot-feedback
//
//  Created by eesaack on 02/08/2023.
//

import UIKit

class RatingView: UIView {
    private var ratingButtons: [UIButton] = []
    var rating: Int = 0 {
        didSet {
            updateRatingButtons()
        }
    }
    var ratingDidChange: ((Int) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupRatingButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRatingButtons() {
        for i in 0..<5 {
            let button = UIButton()
            button.tag = i
            button.setImage(Asset.Common.starEmpty.image, for: .normal)
            button.setImage(Asset.Common.starFilled.image, for: .selected)
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)
            ratingButtons.append(button)
            addSubview(button)
        }
    }
    
    private func updateRatingButtons() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 4
        let buttonSize = bounds.height
        let totalWidth = CGFloat(ratingButtons.count) * buttonSize + CGFloat(ratingButtons.count - 1) * spacing
        let startX = (bounds.width - totalWidth) / 2
        
        for (index, button) in ratingButtons.enumerated() {
            let x = startX + CGFloat(index) * (buttonSize + spacing)
            button.frame = CGRect(x: x, y: 0, width: buttonSize, height: buttonSize)
        }
    }
    
    @objc private func ratingButtonTapped(_ sender: UIButton) {
        rating = sender.tag + 1
        ratingDidChange?(rating)
    }
}

