//
//  EmployeeVacationApplication.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/22.
//

import Foundation
import Alamofire
import UIKit


let DidDismissPostCommentView: Notification.Name = Notification.Name("DidDismissPostCommentView")

class EmployeeVacationApplication : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
  
    
    @IBOutlet weak var imgView: UIImageView!
        
    @IBOutlet weak var totalVacationDate: UILabel!
    @IBOutlet weak var usedVacationDate: UILabel!
    @IBOutlet weak var leftVacationDate: UILabel!
    
    
    @IBOutlet weak var vacationType: UITextField!
    @IBOutlet weak var reason: UITextField!
    @IBOutlet weak var vacationStartDate: UITextField!
    @IBOutlet weak var vacationEndDate: UITextField!
    
    @IBOutlet weak var vacationEndDateText: UILabel!
    @IBOutlet weak var vacationEndDateStar: UILabel!
    @IBOutlet weak var vacationEndDateImg: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var totalusedVacationDate: UITextField!
    
    var imgLogo : UIImage?
    
    var vacationTypeList = ["오전 반차","오후 반차","연차/월차"]
    var vacationPickType = ""
    let dateFormatter = DateFormatter()
    var startDate = ""
    var endDate = ""
    
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EmployeeVacationApplication 실행됨")
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        configToolbar()
        createStartDatePickerView()
        createEndDatePickerView()
       
        pickerView.layer.isHidden = true
        datePickerView.layer.isHidden = true
        totalVacationDate.text = UserDefaults.standard.string(forKey: "totalVacation")
        usedVacationDate.text = UserDefaults.standard.string(forKey: "usedVacation")
        var total = Double(UserDefaults.standard.string(forKey: "totalVacation")!)!
        var used = Double(UserDefaults.standard.string(forKey: "usedVacation")!)
        leftVacationDate.text = String(total - used!)
        totalusedVacationDate.isUserInteractionEnabled = false
        totalusedVacationDate.backgroundColor = .systemGray6
    }
    
    
    @IBAction func vacationOkBtn(_ sender: Any) {
        if vacationType.text == ""{ //연차 유형 없는경우
            print("연차 유형을 선택하세요.")
            let alert = UIAlertController(title: "알림", message: "연차 유형을 선택하세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if vacationType.text == "오전 반차" || vacationType.text == "오후 반차" { //반차인데
            if vacationStartDate.text == ""{ //시작날짜가 없는경우
                let alert = UIAlertController(title: "알림", message: "날짜를 선택하세요.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                print("확인 버튼 누름.")
                //여기서 이제 연차 신청 api 작성해야함. @@@@@@@@@@@@@@@@@@@
                vacationApplication()
            }
        }else if vacationType.text == "연차/월차" {
            if vacationStartDate.text == "" || vacationEndDate.text == ""{ //시작날짜가 없는경우
                let alert = UIAlertController(title: "알림", message: "날짜를 선택하세요.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
               
            }else{
                print("확인 버튼 누름.")
                //여기서 이제 연차 신청 api 작성해야함. @@@@@@@@@@@@@@@@@@@
                vacationApplication()
            }
        }
    }
    
    @IBAction func vacationCancleBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func createStartDatePickerView(){
        print("createStartDatePickerView")
        //toolbar 만들기, done 버튼이 들어갈 곳
        let toolbar = UIToolbar()
        toolbar.sizeToFit() //view 스크린에 딱 맞게 사이즈 조정
        //버튼 만들기
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.startOkBtn))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.startCancleBtn))
        //action 자리에는 이후에 실행될 함수가 들어간다?
        
        //버튼 툴바에 할당
        toolbar.setItems([cancelBT,flexibleSpace,doneBT], animated: true)
        
        //toolbar를 키보드 대신 할당?
        vacationStartDate.inputAccessoryView = toolbar
        //assign datepicker to the textfield, 텍스트 필드에 datepicker 할당
        
        vacationStartDate.inputView = datePicker
        //datePicker 형식 바꾸기
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
    }
    
    func createEndDatePickerView(){
        print("createEndDatePickerView")
        //toolbar 만들기, done 버튼이 들어갈 곳
        let toolbar = UIToolbar()
        toolbar.sizeToFit() //view 스크린에 딱 맞게 사이즈 조정
        //버튼 만들기
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.endOkBtn))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.endCancleBtn))
        //action 자리에는 이후에 실행될 함수가 들어간다?
        
        //버튼 툴바에 할당
        toolbar.setItems([cancelBT,flexibleSpace,doneBT], animated: true)
        
        //toolbar를 키보드 대신 할당?
        vacationEndDate.inputAccessoryView = toolbar
        
        //assign datepicker to the textfield, 텍스트 필드에 datepicker 할당
        
        vacationEndDate.inputView = datePicker
        //datePicker 형식 바꾸기
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        
    }
    @objc func startOkBtn() {
        if vacationType.text == "" {
            startCancleBtn()
            print("연차 유형을 선택하세요.")
            let alert = UIAlertController(title: "알림", message: "연차 유형을 선택하세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }else{
                let formatter = DateFormatter()
                formatter.timeStyle = .none
                formatter.dateFormat = "yyyy-MM-dd"
                vacationStartDate.text = formatter.string(from: datePicker.date)
                startDate = vacationStartDate.text!
                self.view.endEditing(true)
                print("startOK버튼 눌림")
                weekCheck()
            }
        }
    
    @objc func startCancleBtn(){
          self.vacationStartDate.text = nil
          self.vacationStartDate.resignFirstResponder()
        print("startcancle버튼 눌림")
      }
    
    @objc func endOkBtn() {
        if vacationType.text == ""{
            endCancleBtn()
            let alert = UIAlertController(title: "알림", message: "연차 유형을 선택하세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
               
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateFormat = "yyyy-MM-dd"
        vacationEndDate.text = formatter.string(from: datePicker.date)
        endDate = vacationEndDate.text!
            self.view.endEditing(true)
                print("endOK버튼 눌림")
            weekCheck()
            }
        }
    
    @objc func endCancleBtn(){
          self.vacationEndDate.text = nil
          self.vacationEndDate.resignFirstResponder()
        print("endcancle버튼 눌림")
      }
    
    func weekCheck(){
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        if vacationType.text == "오전 반차" || vacationType.text == "오후 반차"{
            print("반차")
            var weekday = Calendar.current.component(.weekday, from: datePicker.date)
           print("weekday", weekday)
            if weekday == 1 || weekday == 7 {
                totalusedVacationDate.text = "0"
            }else {
                totalusedVacationDate.text = "0.5"
            }
        }else if vacationType.text == "연차/월차"{
            if vacationStartDate.text != "" && vacationEndDate.text != "" { //시작날짜와 종료날짜가 둘다 널이 아닐경우 총 사용 연차 계산
                //계산 전에 시작날짜가 종료날짜보다 더 앞이 맞는지 확인.
                let startDate1 = formatter.date(from: vacationStartDate.text!) ?? Date()
                let endDate1 = formatter.date(from: vacationEndDate.text!) ?? Date()
                print("startDate1 @@@@@@@", startDate1)
                print("endDate1 @@@@@@@", endDate1)
                let interval1 = endDate1.timeIntervalSince(startDate1)
                var days1 = Int(interval1 / 86400)
                days1 = days1 + 1
                print("days1 @@@@@@@", days1)
                
                if days1 < 0 {
                    let alert = UIAlertController(title: "알림", message: "날짜를 확인해 주세요.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                        self.vacationStartDate.text = ""
                        self.vacationEndDate.text = ""
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }else {
                //여기다가 총 사용 연차일이 몇일인지 계산해주는 api 넣어야함.
                    print("startDate: ", startDate)
                    print("endDate: ", endDate)
                    startDate = startDate.components(separatedBy: ["-"]).joined()
                    endDate = endDate.components(separatedBy: ["-"]).joined()
                    print("startDate: ", startDate)
                    print("endDate: ", endDate)
                    
                    let userId = UserDefaults.standard.string(forKey: "USER_ID")!
                    let url = "https://kconnect.ksmartech.com:8443/vacation/days/\(startDate)/\(endDate)"
                    var request = URLRequest(url: URL(string: url)!)
                    request.httpMethod = "GET"
                    request.headers = APIManager.getAPIHeader()
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.timeoutInterval = 10
                
                    AF.request(request).responseString{ [self] (response) in
                        switch response.result{
                        case .success(let resData):
                            let decoder = JSONDecoder()
                            let data = resData.data(using: .utf8)
                            
                            if let data = data, let totaldaysModel = try? decoder.decode(TotalDaysModel.self, from: data){
                                totalusedVacationDate.text = String(totaldaysModel.data.bizDays)
                            }else{
                                print("decode error")
                            }
                        case .failure(let error):
                            print("에러에러에러",error)
                        }
                    }

            }
     
                
            }
        }
        
    }
    
    
    
    func configToolbar(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        configPickerView()
        
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        vacationType.inputAccessoryView = toolBar
    }
    @objc func donePicker(){
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.vacationType.text = self.vacationTypeList[row]
    
        if vacationType.text! == "연차/월차"{
            vacationPickType = "ALL_DAY"
            totalusedVacationDate.text = ""
            vacationEndDate.layer.isHidden = false
            vacationEndDateText.layer.isHidden = false
            vacationEndDateImg.layer.isHidden = false
            vacationEndDateStar.layer.isHidden = false
            
        }else if vacationType.text! == "오후 반차"{
            vacationPickType = "PM_HALF"
            totalusedVacationDate.text = "0.5"
            vacationEndDate.layer.isHidden = true
            vacationEndDateText.layer.isHidden = true
            vacationEndDateImg.layer.isHidden = true
            vacationEndDateStar.layer.isHidden = true
        }else{
            vacationPickType = "AM_HALF"
            totalusedVacationDate.text = "0.5"
            vacationEndDate.layer.isHidden = true
            vacationEndDateText.layer.isHidden = true
            vacationEndDateImg.layer.isHidden = true
            vacationEndDateStar.layer.isHidden = true
        }
        self.vacationType.resignFirstResponder()
    }
    
    
    @objc func cancelPicker(){
        self.vacationType.text = nil
        self.vacationType.resignFirstResponder()
    }
    
    func configPickerView(){
        picker.delegate = self
        picker.dataSource = self
        vacationType.inputView = picker
    }

    func vacationApplication(){
        LoadingService.showLoading()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat == "yyyyMMdd"
        let url = "https://kconnect.ksmartech.com:8443/vacation"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        
        let comment = reason.text!
        print("4",comment)
        
        var vacationType = vacationType.text!
        print("3",vacationType)
        if vacationType == "연차/월차"{
            vacationType = "ALL_DAY"
        }else if vacationType == "오전 반차"{
            vacationType = "AM_HALF"
        }else if vacationType == "오후 반차"{
            vacationType = "PM_HALF"
        }
        
        
        var startDate = vacationStartDate.text!
        startDate = startDate.components(separatedBy: ["-"]).joined()
        print("2",startDate)
        
        var endDate = vacationEndDate.text!
        endDate = endDate.components(separatedBy: ["-"]).joined()
        print("1",endDate)
       
       
        if vacationType != "ALL_DAY"{//반차인 경우
            endDate = startDate
        }
                let params = ["vacationType" : "\(vacationType)","startDate" : "\(startDate)","endDate" : "\(endDate)","comment" : "\(comment)"] as Dictionary
      
                //let params = ["vacationType" : "\(vacationType)","startDate" : "\(startDate)","comment" : "\(comment)"] as Dictionary
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])

        }catch{
            print("http Body Error")
        }
        AF.request(request).responseString{ [self] (response) in
            switch response.result{
            case .success(let resData):
                let decoder = JSONDecoder()
                let data = resData.data(using: .utf8)
                print("resData: ", resData)

                if let data = data, let successModel = try? decoder.decode(SuccessModel.self, from: data){
                    if successModel.success{
                        LoadingService.hideLoading()
                        let alert = UIAlertController(title: "알림", message: "정상처리 되었습니다.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                            self.dismiss(animated: true, completion: nil)
                            NotificationCenter.default.post(name: DidDismissPostCommentView, object: nil, userInfo: nil)
                        }
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        LoadingService.hideLoading()
                        var msg = successModel.data
                        let alert = UIAlertController(title: "알림", message: "\(msg)", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                            
                        }
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            case .failure(let error):
                LoadingService.hideLoading()
                let alert = UIAlertController(title: "알림", message: "처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vacationTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vacationTypeList[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.vacationType.text = self.vacationTypeList[row]
    }
}
