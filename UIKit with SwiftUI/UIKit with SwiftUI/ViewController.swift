//
//  ViewController.swift
//  UIKit with SwiftUI
//
//  Created by Koty Stannard on 8/1/22.
//

import UIKit
import SwiftUI

struct SwiftUIView: View {
    
    var body: some View {
        NavigationView {
            List {
                Text("Hello, world")
                Text("Hello, world")
                Text("Hello, world")
                Text("Hello, world")
                Text("Hello, world")
                Text("Hello, world")
                Text("Hello, world")
            }
        }.navigationTitle("List View")
    }
}

class ViewController: UIViewController {
    
    let swiftUIView = SwiftUIView()
    lazy var hostingController = UIHostingController(rootView: swiftUIView)
    
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Present SwiftUI View", for: .normal)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(presentSwiftUIView), for: .touchUpInside)
    }
    
    @objc func presentSwiftUIView() {
        self.present(hostingController, animated: true)
    }
}

