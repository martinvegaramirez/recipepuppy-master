//
//  detailsViewController.swift
//  recipepuppy
//
//  Created by Martin Vega on 30/07/19.
//  Copyright © 2019 Enrico Querci. All rights reserved.
// En esta clase paso la URL a ocupar

import UIKit
import WebKit

class detailsViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    var details =  UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(details.accessibilityLabel)
        
        let myURL = URL(string: details.accessibilityLabel!)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }

   

}
