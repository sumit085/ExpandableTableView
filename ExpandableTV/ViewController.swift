//
//  ViewController.swift
//  ExpandableTV
//
//  Created by Admin on 01/08/20.
//  Copyright © 2020 ExpandableTV. All rights reserved.
//

import UIKit

struct Heading {
    let title : String?
    let dateTime : String?
    var isExpand : Bool?
    var isSmall : Bool?
    var isDropDownShow : Bool?
    let subCategory: [SubHeading]?
    let smallCategory: [SubHeading]?
}

struct SubHeading {
    let title1 : String?
    let title2 : String?
    let title3 : String?
}

class HeadingCell : UITableViewCell{
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgDropdown: UIImageView!
}

extension UIView {
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}

class SubHeadingCell : UITableViewCell{
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
}

class ViewController: UIViewController {
    @IBOutlet weak var tv: UITableView!
    
    var data : [Heading] = [
        Heading(title: "Next Salah Dhuhr", dateTime: "1 hr 27 mins left", isExpand: false,isSmall: true, isDropDownShow: true,
                
                
                subCategory: [
                    SubHeading(title1: "Time",title2: "Adham",title3: "Iqama"),
                    SubHeading(title1: "Fajr",title2: "4:20 AM",title3: "5:00 AM"),
                    SubHeading(title1: "Sunrise",title2: "5:52 AM",title3: ""),
                    SubHeading(title1: "Dhuhr",title2: "1:18 PM",title3: "1:30 PM"),
                    SubHeading(title1: "Asr",title2: "6:28 PM",title3: "6:40 PM"),
                    SubHeading(title1: "Maghrib",title2: "8:42 PM",title3: "8:55 PM"),
                    SubHeading(title1: "Isha",title2: "10:16 PM",title3: "10:30 PM"),
                ],
              
                
                
                smallCategory: [
                    SubHeading(title1: "Time",title2: "Adham",title3: "Iqama"),
                    SubHeading(title1: "Dhuhr",title2: "1:18 PM",title3: "1:30 PM"),

                ]
                ),
       
        
        
        
        Heading(title: "Khateeb Sechedule",dateTime: "Jun 11, 2021", isExpand: true, isSmall: false, isDropDownShow: false,
                subCategory: [
                    SubHeading(title1: "01:00 PM",title2: "02:00 PM",title3: nil),
                    SubHeading(title1: "Guest",title2: "Guest",title3: nil),
                ],
                smallCategory: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController : UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data[section].isExpand ?? false){
            return data[section].subCategory!.count + 1
        } else if (data[section].isSmall ?? false) && (data[section].isExpand ?? false) == false{
            return data[section].smallCategory!.count + 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 60 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row - 1
        let rowData = data[indexPath.section]
        if indexPath.row == 0 {
            let cell = tv.dequeueReusableCell(withIdentifier: String.init(describing: HeadingCell.self)) as! HeadingCell
            cell.lblHeading.text = rowData.title
            cell.lblTime.text = rowData.dateTime
            
            cell.imgDropdown.image = (rowData.isExpand ?? false) ? UIImage.init(named: "down") :  UIImage.init(named: "up")
            cell.imgDropdown.isHidden = !(rowData.isDropDownShow ?? false)
            return cell
        }else{
            let cell = tv.dequeueReusableCell(withIdentifier: String.init(describing: SubHeadingCell.self)) as! SubHeadingCell
            let font = UIFont.systemFont(ofSize: 17, weight: index == 0 ? .bold : .regular)
            cell.lbl1.font = font
            cell.lbl2.font = font
            cell.lbl3.font = font
            var subCategory : [SubHeading]?
            if (rowData.isExpand ?? false){
                subCategory = rowData.subCategory
            }else if (rowData.isSmall ?? false) && (rowData.isExpand ?? false) == false{
                subCategory = rowData.smallCategory
            }
            cell.lbl1.text = subCategory![index].title1
            if subCategory![index].title3 == nil {
                cell.lbl2.text = nil
                cell.lbl3.text = subCategory![index].title2
            }else{
                cell.lbl2.text = subCategory![index].title2
                cell.lbl3.text = subCategory![index].title3
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tv.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 && (data[indexPath.section].isDropDownShow ?? false){
            data[indexPath.section].isExpand = !(data[indexPath.section].isExpand ?? false)
            tv.reloadSections(IndexSet.init(integer: indexPath.section), with: .none)
        }
    }
}
