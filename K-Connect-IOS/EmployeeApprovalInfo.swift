//
//  EmployeeApprovalInfo.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/22.
//


import Foundation
import Alamofire
import UIKit

let DidDismissPostCommentViewController: Notification.Name = Notification.Name("DidDismissPostCommentViewController")

class EmployeeApprovalInfo : UIViewController{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var applicationDateText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var startDateText: UILabel!
    @IBOutlet weak var endDateText: UILabel!
    @IBOutlet weak var reasonText: UILabel!
    
    var vacationId = ""
    var imgLogo : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EmployeeApprovalInfo 실행됨")
       
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        
        var applicationDate = UserDefaults.standard.string(forKey: "approvalDate")
        applicationDate = dateType(date: applicationDate!)
        var startDate = UserDefaults.standard.string(forKey: "approvalStart")
        startDate = dateType(date: startDate!)
        var endDate = UserDefaults.standard.string(forKey: "approvalEnd")
        endDate = dateType(date: endDate!)
        
        if UserDefaults.standard.string(forKey: "approvalType") == "ALL_DAY"{
            typeText.text = "연차/월차"
        }else if UserDefaults.standard.string(forKey: "approvalType") == "AM_HALF"{
            typeText.text = "오전반차"
        }else{
            typeText.text = "오후반차"
        }
        nameText.text = UserDefaults.standard.string(forKey: "approvalName")
        applicationDateText.text = applicationDate
        startDateText.text = startDate
        endDateText.text = endDate
        reasonText.text = UserDefaults.standard.string(forKey: "approvalReason")
        vacationId = UserDefaults.standard.string(forKey: "approvalVacationId")!
    }
    @IBAction func denyBtn(_ sender: Any) { //반려버튼
        let url = "https://"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let alert = UIAlertController(title: "알림", message: "반려 사유를 입력하세요.", preferredStyle: .alert)
        alert.addTextField()
        
        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in // 반려버튼 이후 확인
            var reason = alert.textFields?[0].text
         
            if reason == ""{
                print("반려사유를 입력하세요.")
                let alert = UIAlertController(title: "알림", message: "반려사유를 입력하세요.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else{
                LoadingService.showLoading()
                let params = ["reason" : "\(reason!)"] as Dictionary
                            
                do{
                    try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])

                }catch{
                    print("http Body Error")
                }
                
                AF.request(request).responseString{ (response) in
                    switch response.result{
                    case .success(let resData):
                        LoadingService.hideLoading()
                        let alert = UIAlertController(title: "알림", message: "정상처리 되었습니다.", preferredStyle: .alert)
                        print(resData)
                        
                        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                            self.dismiss(animated: true, completion: nil)//현재 팝업종료
                            NotificationCenter.default.post(name: DidDismissPostCommentViewController, object: nil, userInfo: nil)
                        }
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    case .failure(let error):
                        LoadingService.hideLoading()
                        let alert = UIAlertController(title: "알림", message: "에러가 발생하였습니다.\n잠시후 다시 시도해주세요.", preferredStyle: .alert)
                        
                        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                        }
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                        print(error)
                    }
                }
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancle) in
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func okBtn(_ sender: Any) {
        LoadingService.showLoading()
        let url = "https://"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        AF.request(request).responseString{ (response) in
            switch response.result{
            case .success(let resData):
                LoadingService.hideLoading()
                print("EmployeeApprovalInfo resData: ", resData)
                let alert = UIAlertController(title: "알림", message: "정상처리 되었습니다.", preferredStyle: .alert)
                print(resData)
                
                let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                    self.dismiss(animated: true, completion: nil)//현재 팝업종료
                    NotificationCenter.default.post(name: DidDismissPostCommentViewController, object: nil, userInfo: nil)
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            case .failure(let error):
                LoadingService.hideLoading()
                print(error)
            }
        }
    }
    
    func dateType(date: String) -> String{
        var dateVar = date
        dateVar.insert("-", at: dateVar.index(dateVar.startIndex, offsetBy: 4))
        dateVar.insert("-", at: dateVar.index(dateVar.startIndex, offsetBy: 7))
        return dateVar
    }
}
