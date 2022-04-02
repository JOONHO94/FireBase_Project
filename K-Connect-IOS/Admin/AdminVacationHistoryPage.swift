//
//  AdminVacationHistoryPage.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/22.
//

import UIKit
import DropDown

class AdminVacationHistoryPage: UIViewController {
    
    @IBOutlet weak var Btn_DropDown: UIButton!
    @IBOutlet weak var Lb_Year: UITextField!
    @IBOutlet weak var Lb_TotalDayoff: UILabel!
    @IBOutlet weak var Lb_UsedDayoff: UILabel!
    @IBOutlet weak var Lb_RestoffDayoff: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func DropDown_Year(_ sender: Any) {
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        let sTemp_year = formatter_year.string(from:Date())
        let nYear: Int! = Int(sTemp_year)
        let nCount: Int = nYear - 2010
        
        let dropDown = DropDown()
        dropDown.width = 150
        for i in 0...nCount {
            var nTempYear: Int = nYear - i
            var sYear = String(nTempYear)
            dropDown.dataSource.append(sYear)
        }
        
        dropDown.show()
        dropDown.anchorView = Btn_DropDown
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            Lb_Year.text = item
            print("인덱스 : \(index)")
        }
    }
    
    
    
    @IBAction func DropDown_Dayoff(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.width = 150
        for i in 1...25 {
            var sCount = String(i)
            dropDown.dataSource.append(sCount)
        }
        dropDown.show()
        dropDown.anchorView = Btn_DropDown
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            
          
            
            //Lb_TotalDayoff.text = item
            var RestoffDayoff : Int! = Int(item)
            Lb_RestoffDayoff.text = String(RestoffDayoff)
            print("인덱스 : \(index)")
        }
    }
    
}
