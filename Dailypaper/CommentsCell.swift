//
//  CommentsCell.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/23.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class commentView: UITableViewCell{
    let tableLabel_name = UILabel()
    let tableLabel_comment = UILabel()
    let tablelabel_time = UILabel()
    let tablelabel_numOfLike = UILabel()
    let view_avater = UIImageView()
    let view_praise = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init() {
        self.init(style: .default, reuseIdentifier: "newsComment")
        
        tableLabel_name.frame = CGRect(x: 50, y: 12, width: 150, height: 15)
        tableLabel_name.font = UIFont.boldSystemFont(ofSize: 15)
        contentView.addSubview(tableLabel_name)
        tableLabel_comment.frame = CGRect(x: 50, y: 25, width: Device.width - 60, height: 100)
        tableLabel_comment.numberOfLines = 0
        contentView.addSubview(tableLabel_comment)
        tablelabel_time.frame = CGRect(x: 50, y: 125, width: Device.width - 60, height: 15)
        tablelabel_time.font = UIFont.boldSystemFont(ofSize: 10)
        contentView.addSubview(tablelabel_time)
        
        //FIXME: 位置改一下
        tablelabel_numOfLike.frame = CGRect(x: 390, y: 140, width: 25, height: 15)
        contentView.addSubview(tablelabel_numOfLike)
        view_praise.frame = CGRect(x: 370, y: 140, width: 15, height: 15)
        view_praise.image = #imageLiteral(resourceName: "like_128px_1143450_easyicon.net.png")
        contentView.addSubview(view_praise)
        
        view_avater.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
       // view_avater.image = UIImage(cgImage: <#T##CGImage#>, scale: <#T##CGFloat#>, orientation: <#T##UIImage.Orientation#>)
        contentView.addSubview(view_avater)
        
        
    }
    
    convenience init(byModel newComments: NewsComments, withIndex index: Int){
        self.init(style: .default, reuseIdentifier: "newsComment")
        tableLabel_name.frame = CGRect(x: 50, y: 12, width: 150, height: 15)
        tableLabel_name.text = newComments.comments[index].author
        contentView.addSubview(tableLabel_name)
        tableLabel_comment.frame = CGRect(x: 50, y: 25, width: Device.width - 60, height: 100)
        tableLabel_comment.text = newComments.comments[index].content
        contentView.addSubview(tableLabel_comment)
        tablelabel_time.frame = CGRect(x: 50, y: 125, width: Device.width - 60, height: 15)
        let nowDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd hh:ss"
        let dateString = formatter.string(from: nowDate as Date)
        tablelabel_time.text = dateString
        contentView.addSubview(tablelabel_time)
        tablelabel_numOfLike.frame = CGRect(x: 390, y: 140, width: 25, height: 15)
        tablelabel_numOfLike.text = String(newComments.comments[index].likes)
        contentView.addSubview(tablelabel_numOfLike)
        view_avater.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        contentView.addSubview(view_avater)
        view_praise.frame = CGRect(x: 370, y: 140, width: 15, height: 15)
        view_praise.image = #imageLiteral(resourceName: "like_128px_1143450_easyicon.net.png")
        contentView.addSubview(view_praise)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


