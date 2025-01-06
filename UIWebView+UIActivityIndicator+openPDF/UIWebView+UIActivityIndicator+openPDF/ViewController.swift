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
        // Создаем WKWebView
        self.webView = WKWebView(frame: .zero)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        // Настраиваем Auto Layout
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50) // Оставляем место для UIToolbar
        ])
        
        // Загружаем web-страницу
        if let url = URL(string: "https://mail.ru/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            self.webView.load(URLRequest(url: url))
        }
    }
    
    func setupToolBar() {
        // Создаем UIToolbar
        let toolbar = UIToolbar(frame: .zero)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolbar)
        
        // Настраиваем Auto Layout для Toolbar
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        // Создаем кнопки
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(goBack))
        let forwardButton = UIBarButtonItem(title: "Вперед", style: .plain, target: self, action: #selector(goForward))
        let reloadButton = UIBarButtonItem(title: "Обновить", style: .plain, target: self, action: #selector(reloadPage))
        let flexibleSpace = UIBarButtonItem.flexibleSpace() // Разделитель для равномерного распределения кнопок

        // Добавляем кнопки в UIToolbar
        toolbar.items = [backButton, flexibleSpace, forwardButton, flexibleSpace, reloadButton]
    }
    
    @objc func goBack() {
        guard let webView = webView, webView.canGoBack else { return }
        webView.goBack()
    }

    @objc func goForward() {
        guard let webView = webView, webView.canGoForward else { return }
        webView.goForward()
    }

    @objc func reloadPage() {
        guard let webView = webView else { return }
        webView.reload()
    }
}

