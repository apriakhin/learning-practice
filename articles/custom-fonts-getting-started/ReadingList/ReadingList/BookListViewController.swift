/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import SwiftUI

final class BookListViewController: UIViewController {
  @IBOutlet private var firstBookLabel: UILabel!
  @IBOutlet private var bookHeightConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    addSecondBookLabel()
    dynamicallyTypeFirstBookLabel()
    traitCollectionDidChange(nil)
  }
  
  override func traitCollectionDidChange(
    _ previousTraitCollection: UITraitCollection?
  ) {
    super.traitCollectionDidChange(previousTraitCollection)

    let preferredContentSizeCategory = traitCollection
      .preferredContentSizeCategory

    switch preferredContentSizeCategory {
    case .accessibilityLarge,
      .accessibilityExtraLarge,
      .accessibilityExtraExtraLarge:
      bookHeightConstraint.constant = 200
    case .accessibilityExtraExtraExtraLarge:
      bookHeightConstraint.constant = 300
    default:
      bookHeightConstraint.constant = 100
    }

    view.layoutIfNeeded()
  }

  @IBSegueAction private func addSwiftUILabel(_ coder: NSCoder) -> UIViewController? {
    let controller = UIHostingController(coder: coder, rootView: BookTitleView())
    controller?.view.backgroundColor = .clear
    return controller
  }

  private func addSecondBookLabel() {
    let label = UILabel()
    label.text = "UIKit Apprentice"
    label.textColor = .white
    label.textAlignment = .center
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.scriptFont(withStyle: .title1, size: 16)
    view.addSubview(label)

    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.topAnchor.constraint(equalTo: firstBookLabel.bottomAnchor, constant: 70),
      label.leftAnchor.constraint(equalTo: view.leftAnchor),
      label.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }
  
  private func dynamicallyTypeFirstBookLabel() {
    firstBookLabel.font = firstBookLabel.font.dynamicallyTyped(withStyle: .title1)
  }
}
