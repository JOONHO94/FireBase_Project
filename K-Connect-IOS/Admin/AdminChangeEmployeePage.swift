//
//  AdminChangeEmployeePage.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/23.
//

import UIKit
import DropDown

class AdminChangeEmployeePage: UIViewController {
    
    @IBOutlet weak var Btn_Dayoff: UIButton!
    
    @IBOutlet weak var TextField_Name: UITextField!
    @IBOutlet weak var TextField_Dayoff: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField_Name.delegate = self
    }
    
    @IBAction func DropDown_Dayoff(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.width = 150
        for i in 1...25 {
            var sCount = String(i)
            dropDown.dataSource.append(sCount)
        }
        dropDown.show()
        dropDown.anchorView = Btn_Dayoff
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            TextField_Dayoff.text = item
            print("인덱스 : \(index)")
        }
        
    }
    
    @IBAction func Go_Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)   //모델 끄기
    }
    
    @IBAction func Go_Back2(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension AdminChangeEmployeePage: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        TextField_Name.layer.borderWidth = 1.0
            
        if TextField_Name.text!.count > 5 {
            TextField_Name.layer.borderColor = UIColor.red.cgColor
        }
        else if TextField_Name.text!.count <= 5 {
            TextField_Name.layer.borderColor = UIColor.green.cgColor
        }
        let newLength = TextField_Name.text!.count + string.count - range.length
    
        return !(newLength > 20)
        return true
        
    }
    
}
