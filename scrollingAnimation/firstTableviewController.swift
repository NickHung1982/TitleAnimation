//
//  firstTableviewController.swift
//  scrollingAnimation
//
//  Created by Nick on 8/6/17.
//  Copyright © 2017 NickOwn. All rights reserved.
//

import UIKit

class firstTableviewController: UITableViewController {
    
    @IBOutlet weak var TableHeaderView: UIView!
    @IBOutlet weak var TableHeaderImg: UIImageView!
    private var TitleFramePostion: CGFloat! //position for title in tableview
    private var lastContentOffset: CGFloat! //for check user scroll direction
    private var titleIsShow = false //flag for display on navigation
    var titleLabelView: UILabel! //Custom Labal as navigation's title
    var backNavigationImg: UIImage!
    
    private let kTableHeaderHeight: CGFloat = 250.0
    private let LabelHeight: CGFloat = 21
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 260
        
        TitleFramePostion = 0
        lastContentOffset = 0
        
        //Label for navigation title
        titleLabelView = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabelView.backgroundColor = UIColor.clear
        titleLabelView.textAlignment = .center
        titleLabelView.textColor = UIColor.black
        self.navigationItem.titleView = titleLabelView

        //HeaderView
        TableHeaderView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(TableHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        updateHeaderView()
    }
    private func updateHeaderView(){
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        TableHeaderView.frame = headerRect
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let lb_title = cell.viewWithTag(1) as! UILabel
        self.TitleFramePostion = lb_title.frame.origin.y  // lb_title.frame.size.height
        
        
        // Configure the cell...
        return cell
    }
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateTitle(scrollView)
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updateTitle(scrollView)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        let pointEnd = TitleFramePostion + LabelHeight
        let ShowPersent = (scrollView.contentOffset.y - TitleFramePostion) / LabelHeight
        //print("ShowPersent: \(ShowPersent) , TitleFramePostion: \(TitleFramePostion), offset: \(scrollView.contentOffset.y)")
        if ShowPersent == 0 {return}
        
        //可以移動的範圍
        let navibaraplha = scrollView.contentOffset.y / TitleFramePostion
        if navibaraplha > 0 {
            backNavigationImg = UIImage.fromColor(color: .white, alpha: navibaraplha)
            self.navigationController?.navigationBar.setBackgroundImage(backNavigationImg, for: .default)
        }
        
        if (scrollView.contentOffset.y > TitleFramePostion - LabelHeight) && (self.lastContentOffset < scrollView.contentOffset.y) {
    
            let fontsize = 30*(abs(ShowPersent))
            if abs(ShowPersent) < 0.3 && scrollView.contentOffset.y > TitleFramePostion {
                    titleLabelView.text = "This is test"
                    titleIsShow = true
            }else if titleIsShow == false{
                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                    let lb_title = cell.viewWithTag(1) as! UILabel
                    lb_title.font = lb_title.font.withSize(fontsize)
                }
                
            }
           
        }else{
            //從下往上的時候 判斷是否超過 title 的底部
            if (self.lastContentOffset > scrollView.contentOffset.y) && (scrollView.contentOffset.y < pointEnd ) && abs(ShowPersent) < 1.0 {
                
                titleIsShow = false
                titleLabelView.text = ""
                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                    let lb_title = cell.viewWithTag(1) as! UILabel
                    lb_title.font = lb_title.font.withSize(30)
                }
            }
        
        }

        self.lastContentOffset = scrollView.contentOffset.y
        updateHeaderView()
    }
    
    
    private func updateTitle(_ scrollView: UIScrollView) {
        //print("offset: \(scrollView.contentOffset.y) , totalH: \(TitleFramePostion + LabelHeight)")
        if (scrollView.contentOffset.y > TitleFramePostion + LabelHeight)  {
            titleLabelView.text = "This is test"
            titleIsShow = true
        }else{
            titleLabelView.text = ""
            titleIsShow = false
        }
    }
}

extension UIImage {
    static func fromColor(color:UIColor, alpha:CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.setAlpha(alpha)
        context!.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
}

