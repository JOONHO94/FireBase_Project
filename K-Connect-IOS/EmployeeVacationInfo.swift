//
//  EmployeeVacationInfo.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/18.
//

import Foundation
import UIKit
import Alamofire


class EmployeeVacationInfo : UIViewController {
    

    var imgLogo : UIImage?

    @IBOutlet weak var applicationDate: UILabel!
    @IBOutlet weak var vacationState: UILabel!
    @IBOutlet weak var vacationType: UILabel!
    @IBOutlet weak var vacationReason: UILabel!
    @IBOutlet weak var vacationEndDate: UILabel!
    @IBOutlet weak var vacationStartDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet var applicationDateScroll: UITextView!
    @IBOutlet var stateScroll: UITextView!
    @IBOutlet weak var vacationCancelBtn: UIButton!
    
    var applicationId = UserDefaults.standard.string(forKey: "applicationId")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vacationCancelBtn.layer.isHidden = true
        
        print("EmployeeVacationInfo Start")
        
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        
        applicationDateScroll.isEditable = false
        applicationDateScroll.isScrollEnabled = false
        stateScroll.isEditable = false
        stateScroll.isScrollEnabled = false
        
        applicationDate.text = UserDefaults.standard.string(forKey: "applicationDate")
        vacationState.text = UserDefaults.standard.string(forKey: "applicationState")
        vacationReason.text = UserDefaults.standard.string(forKey: "applicationCommnet")
        vacationStartDate.text = UserDefaults.standard.string(forKey: "applicationStart")
        vacationEndDate.text = UserDefaults.standard.string(forKey: "applicationEnd")
        
        var startDate = vacationStartDate.text!
        startDate.insert("-", at: startDate.index(startDate.startIndex, offsetBy: 4))
        startDate.insert("-", at: startDate.index(startDate.startIndex, offsetBy: 7))
        vacationStartDate.text = startDate
        
        var endDate =  vacationEndDate.text!
        endDate.insert("-", at: endDate.index(endDate.startIndex, offsetBy: 4))
        endDate.insert("-", at: endDate.index(endDate.startIndex, offsetBy: 7))
        vacationEndDate.text = endDate
        
        if vacationState.text == "반려" {
            vacationState.textColor = .red
        }else if vacationState.text == "승인" {
            vacationState.textColor = .blue
        }else if vacationState.text == "대기"{
            vacationCancelBtn.layer.isHidden = false
        }
        
        if UserDefaults.standard.string(forKey: "applicationType") == "ALL_DAY"{
            vacationType.text = "연차/월차"
        }else if UserDefaults.standard.string(forKey: "applicationType") == "AM_HALF"{
            vacationType.text = "오전반차"
        }else{
            vacationType.text = "오후반차"
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        LoadingService.showLoading()
        print("휴가 신청 취소 버튼 눌림.")
        print("applicationId: ", applicationId)
        let url = "https://kconnect.ksmartech.com:8443/vacation/\(applicationId)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        AF.request(request).responseString{ [self] (response) in
            switch response.result{
            case .success(let resData):
                print("asdfasdfasfasdfasdfasdf12412341234")
                let decoder = JSONDecoder()
                let data = resData.data(using: .utf8)
                print("resData: ", resData)

                if let data = data, let successModel = try? decoder.decode(SuccessModel.self, from: data){
                    if successModel.success{
                        LoadingService.hideLoading()
                        let alert = UIAlertController(title: "알림", message: "정상처리 되었습니다.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default){ (ok) in
                            
                            NotificationCenter.default.post(name: DidDismissPostCommentView, object: nil, userInfo: nil)
                        }
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        print(successModel.success)
                    }
                }
            case .failure(let error):
                LoadingService.hideLoading()
                print("에러에러에러",error)
            }
        }
    }
    
}
