//
//  ViewController.swift
//  ExpandableTV
//
//  Created by Admin on 01/08/20.
//  Copyright © 2020 ExpandableTV. All rights reserved.
//

import UIKit

struct Category {
    let title : String?
    var isExpand : Bool?
    let subCategory: [SubCategory]?
}

struct SubCategory {
    let title : String?
 }

class cell1 : UITableViewCell{
    @IBOutlet weak var cL1: UILabel!
}
class cell2 : UITableViewCell{
    @IBOutlet weak var cL2: UILabel!
}

class ViewController: UIViewController {
    @IBOutlet weak var tv: UITableView!
    
    var data : [Category] = [
        Category(title: "first", isExpand: false,
                 subCategory: [SubCategory(title: "cell 1"), SubCategory(title: "cell 2")]),
        Category(title: "second", isExpand: false,
                 subCategory: [SubCategory(title: "cell 1"), SubCategory(title: "cell 2") , SubCategory(title: "cell 3")])
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
        if data[section].isExpand == true {
            return data[section].subCategory!.count + 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row - 1
        if indexPath.row == 0 {
            let cell = tv.dequeueReusableCell(withIdentifier: String.init(describing: cell1.self)) as! cell1
            cell.cL1.text = data[indexPath.section].title
            
            return cell
        }else{
            let cell = tv.dequeueReusableCell(withIdentifier: String.init(describing: cell2.self)) as! cell2
            cell.cL2.text = data[indexPath.section].subCategory![index].title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            data[indexPath.section].isExpand = !(data[indexPath.section].isExpand ?? false)
            tv.reloadSections(IndexSet.init(integer: indexPath.section), with: .none)

        }
        tv.deselectRow(at: indexPath, animated: false)
    }
}
