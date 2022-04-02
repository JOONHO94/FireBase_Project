//
//  DetailController.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/21.
//

import UIKit
import DropDown

class AdminCustomCell: UITableViewCell {
    
    @IBOutlet weak var Lb_Group: UILabel!
}

class AdminEmployeeCell: UITableViewCell {
    @IBOutlet weak var LB_GroupName: UILabel!
    @IBOutlet weak var Lb_GroupEmployee: UILabel!
    
    @IBAction func Btn_Detail(_ sender: Any) {
    }
    
}

class AdminNewGroupCell: UITableViewCell {
    
    @IBOutlet weak var LB_GroupName: UILabel!
    @IBOutlet weak var Btn_DropGroup: UIButton!
    @IBOutlet weak var LB_Lavel: UILabel!
    @IBOutlet weak var Btn_DropLavel: UIButton!
    
    @IBAction func Btn_DropGroup(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.width = 150
        dropDown.dataSource = ["연구기획팀","선행개발팀", "연구개발1팀", "연구개발2팀", "연구개발3팀", "품질개선팀",
                               "품질지원팀", "UI팀", "서비스기획팀", "서비스개발3팀", "서비스운영팀", "서비스개발1팀", "서비스개발2팀"]
        dropDown.show()
        dropDown.anchorView = Btn_DropGroup
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            LB_GroupName.text = item
            print("인덱스 : \(index)")
        }
    }
    
    @IBAction func Btn_DropLavel(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.width = 150
        dropDown.dataSource = ["사원","대리","과장", "차장", "부장"]
        dropDown.show()
        dropDown.anchorView = Btn_DropGroup
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            LB_Lavel.text = item
            print("인덱스 : \(index)")
        }
    }
    
}

