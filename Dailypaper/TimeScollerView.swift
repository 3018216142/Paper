//
//  TimeScollerView.swift
//  Dailypaper
//
//  Created by 王申宇 on 2018/11/29.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

protocol TimerScrollViewDelegate {
    func scrollToIndexOfPage(index:Int)
}

class TimeScollerView: UIView,UIScrollViewDelegate {
    var count: Int = 0
    var timer: Timer!
    var timerDelegate:TimerScrollViewDelegate?
    var scrollView: UIScrollView?
    var pageCT: UIPageControl?
    
    func configScrollView(array:NSArray,contentOffsetIndex:Int){
        count = array.count
        self.clipsToBounds = false
        self.backgroundColor = UIColor.white
        scrollView = UIScrollView(frame: self.bounds)
        scrollView!.delegate = self
        scrollView!.contentSize = CGSize(width:300 , height: 10)
        scrollView!.isPagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.showsVerticalScrollIndicator = false
        self.addSubview(scrollView!)
        }
    
    func createImageViews(array:NSArray,contentOffsetIndex:Int){
        
    }
    
}
