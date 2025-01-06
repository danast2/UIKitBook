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
        self.setupWebView()
        self.setupToolBar()
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
    
    func setupToolBar() {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([self.webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                     self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.webView.heightAnchor.constraint(equalToConstant: 50.0)
                                    ])
        // Создаем кнопки
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(goBack))
        let forwardButton = UIBarButtonItem(title: "Вперед", style: .plain, target: self, action: #selector(goForward))
        let reloadButton = UIBarButtonItem(title: "Обновить", style: .plain, target: self, action: #selector(reloadPage))
        let flexibleSpace = UIBarButtonItem.flexibleSpace() // Для равномерного распределения кнопок

        // Добавляем кнопки на Toolbar
        toolbar.items = [backButton, flexibleSpace, forwardButton, flexibleSpace, reloadButton]
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @objc func reloadPage() {
        webView.reload()
    }

}

