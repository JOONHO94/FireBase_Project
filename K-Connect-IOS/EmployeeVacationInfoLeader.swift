//
//  EmployeeVacationInfoLeader.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/03/07.
//

import Foundation
import UIKit

class EmployeeVacationInfoLeader : UIViewController, UITableViewDataSource, UITableViewDelegate{
 
   
    @IBOutlet weak var imgView: UIImageView!
    var imgLogo : UIImage?
    
    let arrayListCount = UserDefaults.standard.string(forKey: "arrayListCount")
    var name:[String] = []
    var date:[String] = []
    var type:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        print("arrayListCount:", arrayListCount!)
        for i in 1..<Int(arrayListCount!)!{
            var userName = UserDefaults.standard.string(forKey: "arrayListName\(i)")
            var userType = UserDefaults.standard.string(forKey: "arrayListType\(i)")
            var userDate = UserDefaults.standard.string(forKey: "arrayListDate\(i)")
            var typeString = ""
            if userType == "ALL_DAY"{
                typeString = "연차/월차"
            }else if userType == "AM_HALF"{
                typeString = "오전반차"
            }else {
                typeString = "오후반차"
            }
            name.append(userName!)
            type.append(typeString)
            date.append(userDate!)
        }
        print("저장된 name: ", name)
        print("저장된 type: ", type)
        print("저장된 date: ", date)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? InfoCell else{
            return UITableViewCell()
        }
        cell.nameCell.text = name[indexPath.row]
        cell.typeCell.text = type[indexPath.row]
        cell.dateCell.text = date[indexPath.row]
     return cell
    }
}
class InfoCell: UITableViewCell{
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var typeCell: UILabel!
}
