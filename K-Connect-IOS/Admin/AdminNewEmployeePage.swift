//
//  TestPage.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/21.
//

import UIKit
import DropDown


class AdminNewEmployeePage: UIViewController{
    
    @IBOutlet weak var TextField_Position_1: UITextField!
    @IBOutlet weak var TextField_Position_2: UITextField!
    @IBOutlet weak var TextField_Position_3: UITextField!
    @IBOutlet weak var TextField_Department_1: UITextField!
    @IBOutlet weak var TextField_Department_2: UITextField!
    @IBOutlet weak var TextField_Department_3: UITextField!
    @IBOutlet weak var Btn_Position_1: UIButton!
    @IBOutlet weak var Btn_Position_2: UIButton!
    @IBOutlet weak var Btn_Position_3: UIButton!
    @IBOutlet weak var Btn_Department_1: UIButton!
    @IBOutlet weak var Btn_Department_2: UIButton!
    @IBOutlet weak var Btn_Department_3: UIButton!
    
    @IBOutlet weak var TextField_Email: UITextField!
    @IBOutlet weak var TextField_Name: UITextField!
    @IBOutlet weak var TextField_PW: UITextField!
    @IBOutlet weak var TextField_Number: UITextField!
    @IBOutlet weak var TextField_Lavel: UITextField!
    @IBOutlet weak var TextField_Phone: UITextField!
    @IBOutlet weak var TextField_Birth: UILabel!
    @IBOutlet weak var Btn_Back: UIButton!
    @IBOutlet weak var Btn_Delete: UIButton!
    
   
    @IBOutlet weak var Lb_EmailCount: UILabel!
    
    @IBOutlet weak var TextField_Dayoff: UITextField!
    @IBOutlet weak var Btn_Dayoff: UIButton!
    
    
    var nTeamCount: Int = 1
    
    var GroupData = [String]()   //TableCell 갯수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TextField_Email.delegate = self   //TextField의 글자 수를 바로바로 확인할 수 있도록 UITextFieldDelegate 프로토콜을 채택 후 위임자를 자기 자신
        TextField_Name.delegate = self
        
    }
  
    
    
    
  
    @IBAction func TextField_Email(_ sender: Any) {
    }
    
    @IBAction func onClick_BtnCheck(_ sender: Any) {
        if TextField_Email.text == ""{
            Alert_Blank("이메일이 입력 되지 않았습니다")
            return
        }
        else if TextField_Name.text == "" {
            Alert_Blank("이름이 입력 되지 않았습니다")
        }
        else if TextField_PW.text == "" {
            Alert_Blank("임시 비밀번호가 입력 되지 않았습니다")
        }
        else if TextField_Number.text == "" {
            Alert_Blank("사원번호가 입력 되지 않았습니다")
        }
        else if TextField_Lavel.text == "" {
            Alert_Blank("직급이 입력되지 않았습니다")
        }
        else if TextField_Phone.text == "" {
            Alert_Blank("연락처가 입력되지 않았습니다")
        }
        else if TextField_Birth.text == "" {
            Alert_Blank("생일이 입력되지 않았습니다")
        }
        
        
    }
    
    @IBAction func onClick_Btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Btn_BirthPick(_ sender: Any) {
        
    }
    
    
    @IBAction func onClick_BtnAdd(_ sender: Any) {
        nTeamCount += 1
        if(nTeamCount > 3) {
            nTeamCount = 3
        }
        if(nTeamCount > 1) {
            TextField_Position_2.isHidden = false
            TextField_Department_2.isHidden = false
            Btn_Position_2.isHidden = false
            Btn_Department_2.isHidden = false
            
        }
        if(nTeamCount > 2) {
            TextField_Position_3.isHidden = false
            TextField_Department_3.isHidden = false
            Btn_Position_3.isHidden = false
            Btn_Department_3.isHidden = false
        }
        print(nTeamCount)
    }
 
    
    
    @IBAction func onClick_BtnDelete(_ sender: UIButton) {
        nTeamCount -= 1
        if(nTeamCount < 1){
            nTeamCount = 1
        }
        
        if(nTeamCount != 3) {
            TextField_Position_3.isHidden = true
            TextField_Department_3.isHidden = true
            Btn_Position_3.isHidden = true
            Btn_Department_3.isHidden = true
        }
       
        if (nTeamCount == 1) {
            TextField_Position_2.isHidden = true
            TextField_Department_2.isHidden = true
            Btn_Position_2.isHidden = true
            Btn_Department_2.isHidden = true
        }
        print(nTeamCount)
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
    
    func Alert_Blank(_ title: String) {
        let alert = UIAlertController(title: title,
                                      message:"",
                                      preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true, completion: nil)
        
    }
    

    
    @IBAction func Name_MaxLength(_ sender: Any) {

    }
    
    
  
    
}
extension AdminNewEmployeePage: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        TextField_Email.layer.borderWidth = 1.0
        
        Lb_EmailCount.text = String(TextField_Email.text!.count + 1)
        
        if TextField_Email.text!.count > 18 {
            TextField_Email.layer.borderColor = UIColor.red.cgColor
        }
        else if TextField_Email.text!.count <= 20 {
            TextField_Email.layer.borderColor = UIColor.green.cgColor
        }
        let newLengthEmail = TextField_Email.text!.count + string.count - range.length
        
        return !(newLengthEmail > 19)
        //return true
    }
    
    
}

