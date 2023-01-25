//
//  WebViewController.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/13/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: URL?
    
    @IBOutlet weak var webPageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
