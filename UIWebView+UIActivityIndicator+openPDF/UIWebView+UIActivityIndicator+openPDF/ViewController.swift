//
//  ViewController.swift
//  UIWebView+UIActivityIndicator+openPDF
//
//  Created by Даниил Асташов on 06.01.2025.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupWebView() {
        self.webView = WKWebView(frame: .zero)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        //настраиваем auto layout
        NSLayoutConstraint.activate([self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                                    ])
        
        //загружаем web страницу
        if let url = URL(string: "https://www.youtube.com/watch?v=q2PJ0kdrYIs&list=PLmTuDg46zmKD6nI5Meg0_atl0qY-UgTtP&index=18"){
            self.webView.load(URLRequest(url: url))
        }
    }
}

