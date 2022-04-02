//
//  EmployeeMainPage.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/17.
//


import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper



class EmployeeMainPage : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var imgLogo : UIImage?
    @IBOutlet var managementBtn: UIImageView! //관리자 버튼 이미지
    @IBOutlet var imgView: UIImageView! //로고
    @IBOutlet var infoBox: UITextView! //내 정보 테두리
    
    
    //내 정보 label
    @IBOutlet var myInfoTextView: UITextView!
    @IBOutlet var myInfoName: UITextView!
    @IBOutlet var myInfoTeam: UITextView!
    @IBOutlet var myInfoPhone: UITextView!
    @IBOutlet var myInfoVacation: UITextView!
    @IBOutlet var myInfoVacationTotal: UITextView!
    
    //내 정보 text
    @IBOutlet var infoNameText: UITextView!
    @IBOutlet var infoTeamText: UITextView!
    @IBOutlet var infoPhoneText: UITextView!
    
    @IBOutlet weak var infoVacationUsedDay: UITextView!
    @IBOutlet weak var infoVacationDay: UITextView!
    @IBOutlet weak var infoVacationTotalDay: UITextView!
    @IBOutlet weak var infoVacationSlash: UITextView!
    
    //나의 연차 결재 현황
    @IBOutlet var myVacationHistory: UITextView!
    @IBOutlet weak var myVacationHistoryTable: UITableView!
    @IBOutlet weak var approvalTable: UITableView!
    
    //신청 날짜 (나의 연차 결재 현황)
    @IBOutlet weak var applicationDate: UITextView!
    //상태 (나의 연차 결재 현황)
    @IBOutlet weak var applicationState: UITextView!
    
    //신청날짜, 상태 (결재 리스트)
    @IBOutlet weak var approvalName: UITextView!
    @IBOutlet weak var approvalNameLine: UITextView!
    @IBOutlet weak var approvalDate: UITextView!
    @IBOutlet weak var approvalDateLine: UITextView!
    
    //휴가 신청 버튼
    @IBOutlet weak var vacationApplicationBtn: UIButton!
    
    //결재 리스트
    @IBOutlet weak var approvalList: UITextView!
    
    //스크롤뷰 , 뷰
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewSize: UIView!
    
    //팀 내 연차 현황
    @IBOutlet weak var teamVacationHistory: UIButton!
    
    //나의 연차 결재 현황 cell 배열
    var applicationDateCell: [String] = [] //신청날짜
    var applicationStateCell: [String] = [] //상태
    var applicationVacationTypeCell: [String] = [] //연차유형
    var applicationStartDateCell: [String] = [] //시작날짜
    var applicationEndDateCell: [String] = [] //종료날짜
    var applicationCommentCell: [String] = [] //사유
    var applicationIdCell: [String] = [] // 휴가 id
    
    //결재 리스트 cell 배열
    var approvalNameCell: [String] = [] //이름
    var approvalDateCell: [String] = [] //신청 날짜
    var approvalTypeCell: [String] = [] //연차 유형
    var approvalStartCell: [String] = [] //시작 날짜
    var approvalEndCell: [String] = [] //종료 날짜
    var approvalReasonCell: [String] = [] //사유
    var approvalVacationIdCell: [String] = [] //vacationId

    @IBOutlet var applicationDateScroll: UITextView!
    @IBOutlet var stateScroll: UITextView!
    
    @IBOutlet var nameScroll: UITextView!
    @IBOutlet var applicationDateScroll2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EmployeeMainPage 실행됨.")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPostCommentNotification(_noti:)), name: DidDismissPostCommentViewController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPostCommentNotification(_noti:)), name: DidDismissPostCommentView, object: nil)
        
        applicationDateScroll.isScrollEnabled = false
        stateScroll.isScrollEnabled = false
        nameScroll.isScrollEnabled = false
        applicationDateScroll2.isScrollEnabled = false
        nameScroll.isEditable = false
        applicationDateScroll2.isEditable = false
        
        getProfile()
        getVacationHistory()
        
        let teamPosition = UserDefaults.standard.string(forKey: "TEAM_POSITION")!
        let role = UserDefaults.standard.string(forKey: "ROLE")!
        
        if teamPosition == "LEADER"{
            getApprovalList()
        }else{
            approvalList.layer.isHidden = true
            approvalDate.layer.isHidden = true
            approvalName.layer.isHidden = true
            approvalDateLine.layer.isHidden = true
            approvalNameLine.layer.isHidden = true
            teamVacationHistory.layer.isHidden = true
            scrollView.isScrollEnabled = false
        }
        
        if role == "USER"{
            //managementBtn.layer.isHidden = true
        }
        
        //내 정보 테두리 / edit 기능 비활성화
        infoBox.layer.borderWidth = 1.0
        infoBox.isEditable = false
        
        
        //내 정보 bold처리 / edit 기능 비활성화
        myInfoTextView.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        myInfoTextView.isEditable = false
        myInfoName.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        myInfoName.isEditable = false
        myInfoTeam.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        myInfoTeam.isEditable = false
        myInfoPhone.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        myInfoPhone.isEditable = false
        myInfoVacation.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        myInfoVacation.isEditable = false
        myInfoVacationTotal.isEditable = false
        
        //나의 연차 결재 현황 bold처리 / edit 기능 비활성화
        myVacationHistory.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        myVacationHistory.font = UIFont(name: myVacationHistory.font!.fontName, size: 20)
        myVacationHistory.isEditable = false
        
        //결재 리스트 bold 처리 / edit 기능 비활성화
        approvalList.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        approvalList.font = UIFont(name: approvalList.font!.fontName, size: 20)
        approvalList.isEditable = false
        
        //내 정보 text  edit 기능 비활성화
        infoNameText.isEditable = false
        infoTeamText.isEditable = false
        infoPhoneText.isEditable = false
        infoVacationDay.isEditable = false
        infoVacationSlash.isEditable = false
        infoVacationUsedDay.isEditable = false
        infoVacationTotalDay.isEditable = false

        
        //연차신청버튼 테두리
        vacationApplicationBtn.layer.borderWidth = 1
        
        //신청날짜, 상태 edit 기능 비활성화
        applicationDate.isEditable = false
        applicationState.isEditable = false
        
        //로고 이미지 삽입
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        
        //관리자 버튼 터치 활성화
        let managerTap = UITapGestureRecognizer(target: self, action: #selector(managerBtn))
        managementBtn.isUserInteractionEnabled = true
        managementBtn.addGestureRecognizer(managerTap)
        
    }
    override func viewWillAppear(_ animated: Bool) {//네비게이션 back버튼 제거
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func teamVacationInfo(_ sender: UIButton) { //네비게이션바로 연결
        print("팀 내 연차 현황 버튼 눌림")
    }
    //연차신청버튼
    @IBAction func vacationApplicationBtn(_ sender: Any) {
        print("연차신청 버튼 눌림")
    }
    
    //연차내역버튼
    @IBAction func vacationHistoryBtn(_ sender: Any) {
        print("연차내역 버튼 눌림")
    }
    
    //로그아웃 버튼
    @IBAction func logoutBtn(_ sender: UIButton) {
        print("로그아웃 버튼 눌림")
        let alert = UIAlertController(title: "알림", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancle) in
            
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    //관리자 버튼
    @objc func managerBtn(){
        print("관리자 버튼 눌림")
        let storyboard = UIStoryboard(name: "AdminStoryboard", bundle: nil)
                let settingBoard = storyboard.instantiateViewController(withIdentifier: "AdminController")
                    settingBoard.modalPresentationStyle = .fullScreen  // 이거 없으면 팝업.
                    self.present(settingBoard, animated: true, completion: nil)
        
    }

    //내 정보 조회
     func getProfile(){
         let userId = UserDefaults.standard.string(forKey: "USER_ID")!
         let year = getYear()
         let url = "https://kconnect.ksmartech.com:8443/profile/\(userId)/\(year)"
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
                     
                     infoNameText.text! = profileModel.data.userName
                     infoTeamText.text! = profileModel.data.group[0].groupName
                     infoPhoneText.text! = profileModel.data.phoneNumber
                     infoVacationUsedDay.text! = String(profileModel.data.usedDays)
                     infoVacationTotalDay.text! = String(profileModel.data.totalDays)
                     
                     UserDefaults.standard.set(infoVacationTotalDay.text!, forKey: "totalVacation") //총 연차 저장
                     UserDefaults.standard.set(infoVacationUsedDay.text!, forKey: "usedVacation") //사용 연차 저장
                                            
                 }else{
                     print("decode error")
                 }
                 
             case .failure(let error):
                 print("에러에러에러",error)
             }
         }
     }
    
    //나의 연차 결재 현황
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
                         print("vacationId: ", vacationHistoryModel.data.content[i].vacationID)
                         
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

    //결재리스트 가져오는거
    func getApprovalList(){
        print("getApprovalList 실행")
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
            
                if let data = data, let approvalModel = try? decoder.decode(ApprovalModel.self, from: data){
                    
                    let count = approvalModel.data.content.count
                    
                    for i in 0..<count{
                        approvalDateCell.append(approvalModel.data.content[i].createDt)
                        approvalNameCell.append(approvalModel.data.content[i].userName)
                        approvalTypeCell.append(approvalModel.data.content[i].vacationType)
                        approvalStartCell.append(approvalModel.data.content[i].startDate)
                        approvalEndCell.append(approvalModel.data.content[i].endDate)
                        approvalReasonCell.append(approvalModel.data.content[i].comment)
                        approvalVacationIdCell.append(String(approvalModel.data.content[i].vacationID))
                    }
                    approvalTable.reloadData()
                    
                }
            case .failure(let error):
                print("에러에러에러",error)
            }
        }
    }
    
    @objc func didDismissPostCommentNotification(_noti: Notification){
        print("새로고침해야함")
        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "EmployeeStoryboard", bundle: nil)
        
        let settingBoard = storyboard.instantiateViewController(withIdentifier: "EmployeeMainPage")
        settingBoard.modalPresentationStyle = .fullScreen  // 이거 없으면 팝업.
        self.present(settingBoard, animated: true, completion: nil)
        
    }
    func getYear() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: Date())
        return year
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == myVacationHistoryTable{
            return applicationDateCell.count
        }
            return approvalDateCell.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == myVacationHistoryTable,
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell{
            //여기서 신청 날짜 / 상태 를 넣어줌.
            cell.vacationApplicationDate.text = applicationDateCell[indexPath.row]
                   if applicationStateCell[indexPath.row] == "반려"{
                       cell.vacationApplicationState.text = applicationStateCell[indexPath.row]
                       cell.vacationApplicationState.textColor = .red
                   } else if applicationStateCell[indexPath.row] == "승인"{
                       cell.vacationApplicationState.text = applicationStateCell[indexPath.row]
                       cell.vacationApplicationState.textColor = .blue
                   }else{
                       cell.vacationApplicationState.text = applicationStateCell[indexPath.row]
                       cell.vacationApplicationState.textColor = .black
                   }
            return cell
        }else if tableView == approvalTable,
                 let cell = tableView.dequeueReusableCell(withIdentifier: "approvalCell") as? ApprovalCell{
            var date = approvalDateCell[indexPath.row]
            date.insert("-", at: date.index(date.startIndex, offsetBy: 4))
            date.insert("-", at: date.index(date.startIndex, offsetBy: 7))
            
            cell.approvalCellDate.text = date
            cell.approvalCellName.text = approvalNameCell[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated:true)
        
        if tableView == myVacationHistoryTable{
        print("tableview application click")
        userDefaults(var: applicationIdCell[indexPath.row], var: "applicationId")
            userDefaults(var: applicationDateCell[indexPath.row], var: "applicationDate")
            userDefaults(var: applicationStateCell[indexPath.row], var: "applicationState")
            userDefaults(var: applicationVacationTypeCell[indexPath.row], var: "applicationType")
            userDefaults(var: applicationStartDateCell[indexPath.row], var: "applicationStart")
            userDefaults(var: applicationEndDateCell[indexPath.row], var: "applicationEnd")
            userDefaults(var: applicationCommentCell[indexPath.row], var: "applicationCommnet")
   
        let viewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeVacationInfo")
            viewControllerName?.modalTransitionStyle = .flipHorizontal

        if let view = viewControllerName {
            view.modalTransitionStyle = .coverVertical
            self.present(view, animated: true, completion: nil)
            }
        } else{
            userDefaults(var: approvalNameCell[indexPath.row], var: "approvalName")
            userDefaults(var: approvalDateCell[indexPath.row], var: "approvalDate")
            userDefaults(var: approvalTypeCell[indexPath.row], var: "approvalType")
            userDefaults(var: approvalStartCell[indexPath.row], var: "approvalStart")
            userDefaults(var: approvalEndCell[indexPath.row], var: "approvalEnd")
            userDefaults(var: approvalReasonCell[indexPath.row], var: "approvalReason")
            userDefaults(var: approvalVacationIdCell[indexPath.row], var: "approvalVacationId")
            let viewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeApprovalInfo")
                viewControllerName?.modalTransitionStyle = .flipHorizontal

            if let view = viewControllerName {
                view.modalTransitionStyle = .coverVertical
                self.present(view, animated: true, completion: nil)
                }
        }
    }
    
    func userDefaults(var date: String , var key: String){
        UserDefaults.standard.set(date,forKey: key)
    }
}
   

class CustomCell: UITableViewCell{
    @IBOutlet weak var vacationApplicationDate: UILabel!
    @IBOutlet weak var vacationApplicationState: UILabel!
}

class ApprovalCell: UITableViewCell{
    @IBOutlet weak var approvalCellDate: UILabel!
    @IBOutlet weak var approvalCellName: UILabel!
}


extension UIScrollView {
    func updateContentSize() {
            let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
            
            // 계산된 크기로 컨텐츠 사이즈 설정
            self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
        }
        
        private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
            var totalRect: CGRect = .zero
            // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
            for subView in view.subviews {
                totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
            }
            // 최종 계산 영역의 크기를 반환
            return totalRect.union(view.frame)
        }
}


    
