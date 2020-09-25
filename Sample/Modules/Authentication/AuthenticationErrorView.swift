//
//  AuthenticationErrorView.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 24.09.2020.
//

import Foundation
import UIKit

private let textToButtonOffset: CGFloat = 20

class AuthenticationErrorView: UIView {
    private(set) weak var textLabel: UILabel!
    private(set) weak var repeatButton: UIButton!

    var textInsets: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 15, bottom: 10, right: 15)
    var buttonInsets: UIEdgeInsets = UIEdgeInsets.init(top: 4, left: 7, bottom: 4, right: 7)
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let size = frame.size

        let rWidth = size.width - textInsets.left - textInsets.right
        let textSize = textLabel.text?.boundingSize(with: CGSize(width: rWidth, height: .infinity), options: .usesLineFragmentOrigin, attributes: [.font: textLabel.font]) ?? .zero

        let buttonText = repeatButton.title(for: .normal)
        let buttonFont = repeatButton.titleLabel?.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let buttonInsets = repeatButton.titleEdgeInsets
        var btSize = buttonText?.boundingSize(with: CGSize(width: rWidth, height: .infinity), options: .usesFontLeading, attributes: [.font: buttonFont]) ?? .zero
        btSize.width += buttonInsets.left + buttonInsets.right
        btSize.height += buttonInsets.top + buttonInsets.bottom

        let textOriginY = size.height/2 - (textSize.height + textToButtonOffset + btSize.height)/2

        textLabel.frame = CGRect.init(x: textInsets.left, y: textOriginY, width: rWidth, height: textSize.height)
        repeatButton.frame = CGRect.init(x: (size.width/2 - btSize.width/2).rounded(),
                                         y: textLabel.frame.maxY + textToButtonOffset,
                                         width: btSize.width,
                                         height: btSize.height)
    }

    // MARK: private methods
    private func setupViews() {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        addSubview(textLabel)
        self.textLabel = textLabel

        let repeatButton = UIButton(type: .custom)
        repeatButton.layer.cornerRadius = 4
        repeatButton.layer.borderColor = UIColor.blue.cgColor
        repeatButton.layer.borderWidth = 1
        repeatButton.setTitle(NSLocalizedString("repeat_request", comment: ""), for: .normal)
        repeatButton.setTitleColor(.blue, for: .normal)
        repeatButton.titleEdgeInsets = buttonInsets
        addSubview(repeatButton)
        self.repeatButton = repeatButton
    }
}
