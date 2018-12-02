//
//  FirstTableView.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class newsTableView: UITableViewCell{
    
    let titleLable = UILabel()
    let ImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "newsTableView")
        
        titleLable.frame = CGRect(x: 20, y: 20, width: Device.width - 100, height: 43)
        contentView.addSubview(titleLable)
        ImageView.frame = CGRect(x: (titleLable.frame.maxX + 200), y: titleLable.frame.minY, width: 43, height: 43)
        contentView.addSubview(ImageView)
    }
    
    convenience init(byModel lastestNews: LastestNews, withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "newsTableView")
        //设置新闻标题
        titleLable.frame = CGRect(x: 20, y: 20, width: Device.width - 100, height: 43)
        titleLable.text = lastestNews.stories[index].title
        contentView.addSubview(titleLable)
        
        //设置新闻图片
        ImageView.frame = CGRect(x: (titleLable.frame.maxX + 200) , y: titleLable.frame.minY, width: 43, height: 43)
        ImageView.sd_setImage(with: URL(string: lastestNews.stories[index].images![0]), completed: nil )
        contentView.addSubview(ImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
