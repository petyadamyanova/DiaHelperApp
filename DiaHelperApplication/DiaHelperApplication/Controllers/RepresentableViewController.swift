//
//  RepresentableViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 1.11.24.
//

import UIKit
import SwiftUI

struct RepresentableViewController<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(viewController: @autoclosure @escaping () -> ViewController) {
        self.viewController = viewController()
    }

    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
       //
    }
}
