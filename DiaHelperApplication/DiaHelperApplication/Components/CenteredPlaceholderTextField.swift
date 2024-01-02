//
//  CenteredPlaceholderTextField.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import Foundation
import UIKit

class CenteredPlaceholderTextField: UITextField {
    override var placeholder: String? {
          didSet {
              updatePlaceholderAttributes()
          }
      }

      override init(frame: CGRect) {
          super.init(frame: frame)
          updatePlaceholderAttributes()
      }

      required init?(coder: NSCoder) {
          super.init(coder: coder)
          updatePlaceholderAttributes()
      }

      private func updatePlaceholderAttributes() {
          guard let placeholderText = placeholder else { return }
          
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.alignment = .center

          let attributes: [NSAttributedString.Key: Any] = [
              .foregroundColor: UIColor.lightGray,
              .paragraphStyle: paragraphStyle,
          ]

          attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
      }
}
