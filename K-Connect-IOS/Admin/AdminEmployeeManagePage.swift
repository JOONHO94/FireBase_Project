//
//  AdminEmployeeManagePage.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/16.
//

import UIKit
import DropDown

class AdminEmployeeManagePage: UIViewController {
//
//    @IBOutlet weak var TableView_IF: UITableView!
//    @IBOutlet weak var Btn_DropYear: UIButton!
//    @IBOutlet weak var TextField_Year: UITextField!
//    @IBOutlet weak var TextField_Group: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        TableView_IF.delegate = self
//        TableView_IF.dataSource = self
//
    }
//    @IBAction func Btn_GoAdminNewEmployee(_ sender: Any) {
//        if let Controller = self.storyboard?.instantiateViewController(withIdentifier: "AdminNewEmployeePage") {
//            self.navigationController?
//                .pushViewController(Controller,animated: true)
//        }
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = TableView_IF.dequeueReusableCell(withIdentifier: "AdminEmployeeCell", for: indexPath) as? AdminEmployeeCell
////       else{
////            return UITableViewCell()
////        }
////        cell.LB_GroupName.text = "\(indexPath.row)"
//       return cell
//    }   //어떤 데이터 인지
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Click : \(indexPath.row)")
//    }
    
    @IBAction func Drop_Year(_ sender: Any) {
        let dropDown = DropDown()
        var Array_Year : [String] = []
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let sTemp_year = formatter.string(from:Date())
        let nYear: Int! = Int(sTemp_year)
        let nCount: Int = nYear - 2010   //창립연도부터
        
        dropDown.width = 100
        for i in 0...nCount {
            var nTempYear: Int = nYear - i
            var sYear = String(nTempYear)
            dropDown.dataSource.append(sYear)
        }
        
//        dropDown.show()
//        dropDown.anchorView = Btn_DropYear
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("선택한 아이템 : \(item)")
//            TextField_Year.text = item
//            print("인덱스 : \(index)")
            //self.dropDown.clearSelection()
        }
    }
    
    //@IBAction func Drop_GroupName(_ sender: Any) {
//        let dropDown = DropDown()
//        dropDown.width = 150
//        dropDown.dataSource = ["연구기획팀","선행개발팀", "연구개발1팀", "연구개발2팀", "연구개발3팀", "품질개선팀",
//                               "품질지원팀", "UI팀", "서비스기획팀", "서비스개발3팀", "서비스운영팀", "서비스개발1팀", "서비스개발2팀"]
//        dropDown.show()
//        dropDown.anchorView = Btn_DropYear
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("선택한 아이템 : \(item)")
//            TextField_Group.text = item
//            print("인덱스 : \(index)")
       // }
   // }
//    @IBAction func Btn_Search(_ sender: Any) {
//        let alert = UIAlertController(title: "검색하시겠습니까?",
//                                      message:"",
//                                      preferredStyle: UIAlertController.Style.alert)
//        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
//        alert.addAction(cancle)
//        present(alert,animated: true, completion: nil)
//
//    }
    



