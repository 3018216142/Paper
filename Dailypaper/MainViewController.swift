//
//  ViewController.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
//import SwiftyJSON
import Alamofire
import SDWebImage
import MJRefresh

struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class MainViewController: UIViewController {
    
    var lastestnews: LastestNews!
    let tableView = UITableView(frame: .zero, style: .grouped)
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var newsTableView: UITableView!
    var BarImageView: UIView?
    
//    override func loadView() {
//        super.loadView()
//    }
    
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshNormalHeader()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false

        refreshControl.addTarget(self, action: #selector(refreshData),for: UIControl.Event.valueChanged)

        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        
        
        loadData()
        let nowDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd "
        let dateString = formatter.string(from: nowDate as Date)
        navigationItem.title = "今日新闻" + " " + dateString
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .Blue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks , target: self, action: #selector(menu))
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
//        refreshControl.addTarget(self, action: #selector(refreshData),
//                                 for: .valueChanged)
//        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
//        newsTableView.addSubview(refreshControl)
//        refreshData()
        
        self.view.addSubview(tableView)
    }
    
   func loadData() {
        LastestNewsHelper.getLastestNews(success: { lastestNews in
            self.lastestnews = lastestNews
//            self.navigationItem.title = "今日热闻 (\(lastestNews.date))"
            self.tableView.reloadData()
        }, failure: { _ in
            
        })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "下拉可刷新"
    }
//
//    // 刷新数据
//
  @objc   func refreshData() {

        self.loadData()
    }
    
    
    
//    @objc func refreshData() {
//        
//    }
    @objc func menu() {

    }
    
}
    extension UIColor{
        static var Blue: UIColor{
            return UIColor(red: 66/255, green: 156/255, blue: 210/255, alpha: 1.0)
        }
    }

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastestnews == nil { return 0 }
        return lastestnews.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        cell.textLabel?.text = lastestnews.stories[indexPath.row].title
        cell.imageView?.sd_setImage(with: URL(string: lastestnews.stories[indexPath.row].images![0]))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NewsFigure.id = lastestnews.stories[indexPath.row].id
        let b = DetailViewController()
        b.story = lastestnews.stories[indexPath.row]
        
//       let a = CommentsViewController()
//        a.story = lastestnews.stories[indexPath.row]
        
        navigationController?.pushViewController(b, animated: true)
    }
    
}

//extension MainViewController:  SliderGalleryControllerDelegate {
//    let top_header_style = MJRefreshGifHeader()
//    let bottom_footer = MJRefreshAutoNormalFooter()
//    @IBOutlet var my_tableview: UITableView!
//    var sliderGallery : SliderGalleryController!
//    
//}

