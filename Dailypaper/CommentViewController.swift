//
//  CommentViewController.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage
import MJRefresh

class CommentsViewController: UIViewController {
    
    var comment: Comment!
    var newComments: NewsComments!
    let tableView = UITableView(frame: .zero, style: .grouped )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "评论"
        loadComment()
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
    }
    func loadComment() {
        NewsCommentsHelper.getComments(success: { newsComments in
            self.newComments = newsComments
            self.tableView.reloadData()
            print(newsComments)
            
        }, failure: { _ in
            
        })
    }
    
}
extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CommentsFigure.id = newComments.comments[indexPath.row].id
        let a = CommentsViewController()
        a.comment = newComments.comments[indexPath.row]
        
        navigationController?.pushViewController(a, animated: true)
    }
    
}
extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newComments == nil { return 0 }
        return newComments.comments.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: "")
//        cell.detailTextLabel?.text = newComments.comments[indexPath.row].content
//        cell.theCommentText.text = newComments.comments[indexPath.row].content
        
        let cell = commentView()
        cell.tableLabel_comment.text = newComments.comments[indexPath.row].content
        cell.tableLabel_name.text = newComments.comments[indexPath.row].author
        let like = "\(newComments.comments[indexPath.row].likes)"
//        String like = "\(newComments.comments[indexPath.row].likes)"
        cell.tablelabel_numOfLike.text = like
        
        var a = newComments.comments[indexPath.row].time
        let Time = "\(newComments.comments[indexPath.row].time)"
        cell.tablelabel_time.text = Time
        
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if newComments == nil {
            return "没有更多评论"
        }else{
            return "有\(newComments.comments.count)条评论"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "已加载全部评论"
    }
    
}
