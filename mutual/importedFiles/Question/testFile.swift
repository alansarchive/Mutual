//
//  testFile.swift
//  mutual
//
//  Created by Marc Jiang on 6/15/25.
//

import UIKit
import SwiftUI
class LoginV: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testView = Welcome()
        
        let hostingController = UIHostingController(rootView: testView)
        hostingController.navigationController?.navigationBar.isHidden = true
        hostingController.navigationController?.navigationBar.isUserInteractionEnabled = false
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar for this screen
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Optional: Add this to show the navigation bar again when leaving this screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unhide the navigation bar for the next screen
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}




struct uiconvert: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> CustomTabBar {
        let tb = CustomTabBar()
        let nav = UINavigationController(rootViewController: tb)
        nav.navigationBar.isHidden = true
        nav.isNavigationBarHidden = true
        nav.navigationBar.isUserInteractionEnabled = false
        if let navBar = tb.navigationController?.navigationBar {
            navBar.isUserInteractionEnabled = false
        }
        return tb
    }
    
    func updateUIViewController(_ uiViewController: CustomTabBar, context: Context) {
        
    }
    
    typealias UIViewControllerType = CustomTabBar
    
   
    

    
}
