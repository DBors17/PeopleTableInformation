//
//  WebViewController.swift
//  PeopleTableInformation
//
//  Created by Dorin on 05.04.2025.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController{
    var webView: WKWebView!
    var urlString: String?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString, let url = URL(string : urlString) else{
            print("URL invalid")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)

    }
}
