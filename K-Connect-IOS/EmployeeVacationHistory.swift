//
//  EmployeeVacationHistory.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/25.
//


import Foundation
import UIKit
import Alamofire

class EmployeeVacationHistory : UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myVacationHistoryTable: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var yearLabel: UITextField!
    var imgLogo : UIImage?
    
    var applicationDateCell: [String] = [] //신청날짜
    var applicationStateCell: [String] = [] //상태
    var applicationVacationTypeCell: [String] = [] //연차유형
    var applicationStartDateCell: [String] = [] //시작날짜
    var applicationEndDateCell: [String] = [] //종료날짜
    var applicationCommentCell: [String] = [] //사유
    var applicationIdCell: [String] = []
    let picker = UIPickerView()
    var vacationYearList = ["2017"]
    var vacationPickYear = ""
    @IBOutlet var applicationDateScroll: UITextView!
    @IBOutlet var stateScroll: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var totalVacationDate: UILabel!
    @IBOutlet weak var leftVacationDate: UILabel!
    @IBOutlet weak var usedVacationDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        applicationDateScroll.isEditable = false
        applicationDateScroll.isScrollEnabled = false
        stateScroll.isEditable = false
        stateScroll.isScrollEnabled = false
        configToolbar()
        getVacationHistory()
        scrollView.isScrollEnabled = false
        totalVacationDate.text = UserDefaults.standard.string(forKey: "totalVacation")
        usedVacationDate.text = UserDefaults.standard.string(forKey: "usedVacation")
        var total = Double(UserDefaults.standard.string(forKey: "totalVacation")!)!
        var used = Double(UserDefaults.standard.string(forKey: "usedVacation")!)
        leftVacationDate.text = String(total - used!)
        pickerView.layer.isHidden = true
        var nowyear = getYear()
        yearLabel.text = "\(nowyear)"
        while true {
            if vacationYearList[vacationYearList.count - 1] < nowyear { //연도 리스트 안에값이 지금 연도 보다 작으면?
                var maxYear = vacationYearList[vacationYearList.count - 1]
                vacationYearList.append(String(Int(maxYear)! + 1)) // 연도리스트 최고값 + 1을 리스트에 저장.
            }else if vacationYearList[vacationYearList.count - 1] == nowyear {
                //연도리스트 값이랑 지금 연도랑 같으면 더 할필요 없음.
                break
            }
        }
    }
    func getProfile(var year : String){
        let userId = UserDefaults.standard.string(forKey: "USER_ID")!
        let url = "https://"
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
                
                if let data = data, let profileModel = try? decoder.decode(ProfileModel.self, from: data){
                    
                    totalVacationDate.text! = String(profileModel.data.totalDays)
                    usedVacationDate.text! = String(profileModel.data.usedDays)
                    var total = String(Double(totalVacationDate.text!)!)
                    var used = String(Double(usedVacationDate.text!)!)
                    var left = Double(total)! - Double(used)!
                    leftVacationDate.text = String(left)
                    
                }else{
                    print("decode error")
                }
                
            case .failure(let error):
                print("에러에러에러",error)
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
        yearLabel.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(){
        applicationDateCell.removeAll()
        applicationStateCell.removeAll()
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.yearLabel.text = self.vacationYearList[row]
        getVacationHistory(var: self.vacationYearList[row])
        getProfile(var: self.vacationYearList[row])
        self.yearLabel.resignFirstResponder()
    }

    @objc func cancelPicker(){
        self.yearLabel.text = nil
        self.yearLabel.resignFirstResponder()
    }
    
    func configPickerView(){
        picker.delegate = self
        picker.dataSource = self
        yearLabel.inputView = picker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vacationYearList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vacationYearList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.yearLabel.text = self.vacationYearList[row]
    }
    
    func getVacationHistory(var year : String){
        let url = "https://"
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
                
                if let data = data, let vacationHistoryModel = try? decoder.decode(VacationHistoryListModel.self, from: data){
                    
                 let count = vacationHistoryModel.data.content.count
                    
                    for i in 0..<count{
                        applicationIdCell.append(String(vacationHistoryModel.data.content[i].vacationID))
                        applicationDateCell.append(vacationHistoryModel.data.content[i].createDt)
                        
                        applicationVacationTypeCell.append(vacationHistoryModel.data.content[i].vacationType)
                        applicationStartDateCell.append(vacationHistoryModel.data.content[i].startDate)
                        applicationEndDateCell.append(vacationHistoryModel.data.content[i].endDate)
                        applicationCommentCell.append(vacationHistoryModel.data.content[i].comment)
                        if vacationHistoryModel.data.content[i].statusType == "APPROVAL"{
                            applicationStateCell.append("승인")
                        }else if vacationHistoryModel.data.content[i].statusType == "DENY"{
                            applicationStateCell.append("반려")
                        }else if vacationHistoryModel.data.content[i].statusType == "CANCEL"{
                            applicationStateCell.append("취소")
                        }else{
                            applicationStateCell.append("대기")
                        }
                    }
                    myVacationHistoryTable.reloadData()
                }

            case .failure(let error):
                print("에러에러에러",error)
            }
        }
    }
    func getVacationHistory(){
        let year = getYear()
        let url = "https://"
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
                
                if let data = data, let vacationHistoryModel = try? decoder.decode(VacationHistoryListModel.self, from: data){
                    
                 let count = vacationHistoryModel.data.content.count
                    
                    for i in 0..<count{
                        applicationIdCell.append(String(vacationHistoryModel.data.content[i].vacationID))
                        applicationDateCell.append(vacationHistoryModel.data.content[i].createDt)
                        
                        applicationVacationTypeCell.append(vacationHistoryModel.data.content[i].vacationType)
                        applicationStartDateCell.append(vacationHistoryModel.data.content[i].startDate)
                        applicationEndDateCell.append(vacationHistoryModel.data.content[i].endDate)
                        applicationCommentCell.append(vacationHistoryModel.data.content[i].comment)
                        if vacationHistoryModel.data.content[i].statusType == "APPROVAL"{
                            applicationStateCell.append("승인")
                        }else if vacationHistoryModel.data.content[i].statusType == "DENY"{
                            applicationStateCell.append("반려")
                        }else if vacationHistoryModel.data.content[i].statusType == "CANCEL"{
                            applicationStateCell.append("취소")
                        }else{
                            applicationStateCell.append("대기")
                        }
                    }
                    myVacationHistoryTable.reloadData()
                }

            case .failure(let error):
                print("에러에러에러",error)
            }
        }
    }
    func getYear() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: Date())
        return year
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applicationDateCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryCell else{
            return UITableViewCell()
        }
        cell.dateCell.text = applicationDateCell[indexPath.row]
        if applicationStateCell[indexPath.row] == "반려"{
            cell.stateCell.text = applicationStateCell[indexPath.row]
            cell.stateCell.textColor = .red
        } else if applicationStateCell[indexPath.row] == "승인"{
            cell.stateCell.text = applicationStateCell[indexPath.row]
            cell.stateCell.textColor = .blue
        }else{
            cell.stateCell.text = applicationStateCell[indexPath.row]
            cell.stateCell.textColor = .black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated:true)
        
        if tableView == myVacationHistoryTable{
        print("tableview application click")
        UserDefaults.standard.set(applicationIdCell[indexPath.row], forKey: "applicationId")
        UserDefaults.standard.set(applicationDateCell[indexPath.row], forKey: "applicationDate")
        UserDefaults.standard.set(applicationStateCell[indexPath.row], forKey: "applicationState")
        UserDefaults.standard.set(applicationVacationTypeCell[indexPath.row], forKey: "applicationType")
        UserDefaults.standard.set(applicationStartDateCell[indexPath.row], forKey: "applicationStart")
        UserDefaults.standard.set(applicationEndDateCell[indexPath.row], forKey: "applicationEnd")
        UserDefaults.standard.set(applicationCommentCell[indexPath.row], forKey: "applicationCommnet")
                
        let viewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeVacationInfo")
            viewControllerName?.modalTransitionStyle = .flipHorizontal

        if let view = viewControllerName {
            view.modalTransitionStyle = .coverVertical
            self.present(view, animated: true, completion: nil)
            }
        }
    }
}
    
class HistoryCell: UITableViewCell{
    @IBOutlet weak var stateCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
}
