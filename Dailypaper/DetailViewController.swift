//
//  DetailViewController.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SDWebImage
import WebKit

class DetailViewController: UIViewController,WKUIDelegate{
    var story: Story!
    var newsDetail: NewsDetail!
    var newscomment: NewsComments!
    var webview = WKWebView()
    var button = UIButton()
    var bbi = UIBarButtonItem()

    
    override func viewDidLoad(){
        super .viewDidLoad()
        view.backgroundColor = .white
        loadDetail()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        bbi = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = bbi
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        button.setTitle("评论", for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webview = WKWebView(frame: .zero, configuration: webConfiguration)
        webview.uiDelegate = self
        view = webview
    }
    
    func loadDetail() {
        NewsDetailHelper.getNewsDetails(storyID: story.id, success: {
                newsDetail in
            self.navigationItem.title = "\(newsDetail.title)"
            let viewWeb = WKWebView(frame: CGRect(x: 0, y: 0, width: Device.width, height: Device.height))
            let urL = URL(string: "https://daily.zhihu.com/story/\(newsDetail.id)")
            viewWeb.load(URLRequest(url: urL!))
            self.view.addSubview(viewWeb)
//            self.webview.loadHTMLString("\(newsDetail.body)", baseURL: nil)
//            var button:UIButton =
        }, failure: {_ in
                
        })
    }
    
    @objc func click() {
        navigationController?.pushViewController(CommentsViewController(), animated: true)
    }
    
}
