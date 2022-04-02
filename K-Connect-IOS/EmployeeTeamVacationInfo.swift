//
//  EmployeeTeamVacationInfo.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/02/28.
//
import Foundation
import UIKit
import FSCalendar
import Alamofire

class EmployeeTeamVacationInfo : UIViewController, FSCalendarDelegate, FSCalendarDataSource , FSCalendarDelegateAppearance, UITableViewDataSource, UITableViewDelegate{
    

    
    var imgLogo : UIImage?
    
    @IBOutlet weak var vacationTable: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var calendar = FSCalendar()
    var nameTableCell: [String] = []
    var usedTableCell: [String] = []
    var totalTableCell: [String] = []
    var dates: [Date] = []//이벤트 날짜 들어감.
    var vacationArray: [[String]] = [[]] //해당 달 휴가자 이름/날짜 들어감 ex) ["안인선", "20220203", "20220204", "20220228"], ["홍찬오", "20220203", "20220204"], ["이준협", "20220204"], ["이동준", "20220203", "20220228"]
    
    @IBOutlet var nameScroll: UITextView!
    @IBOutlet var usedTotalScroll: UITextView!
    @IBOutlet var infoScroll: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo = UIImage(named: "logo.png")
        imgView.image = imgLogo
        nameScroll.isEditable = false
        nameScroll.isScrollEnabled = false
        usedTotalScroll.isEditable = false
        usedTotalScroll.isScrollEnabled = false
        infoScroll.isEditable = false
        infoScroll.isScrollEnabled = false
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.appearance.headerDateFormat = "YYYY년 MM월" // 헤더 날짜 포맷
        calendarView.calendarWeekdayView.weekdayLabels[0].textColor = .blue
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleAlignment = .center
        calendarView.headerHeight = 45
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.titleWeekendColor = .red
    
        getVacationList()
        getVacationDate()
    }
    func getVacationDate(var year:String, var month:String){//팀 연차 현황 가져오는거
        vacationArray.removeAll()
        print("getVacationDate 실행")
        let year = year
        var month = month
        
        if (Int(month)! < 10) { //10보다 작으면 0을 하나 붙여줘서 1 -> 01 이런식으로 바꿔줘야함
            month.insert("0",at: month.index(month.startIndex, offsetBy: 0))
        }
        print("연도 월:\(year)\(month)")
        let url = "https://kconnect.ksmartech.com:8443/vacation/group/\(year)\(month)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        AF.request(request).responseString{ [self] (response) in
            switch response.result{
            case .success(let resData):
                print("resData getVacationDate:" ,resData)
                let decoder = JSONDecoder()
                let data = resData.data(using: .utf8)
                
                if let data = data, let vacationDateModel = try? decoder.decode(VacationDateModel.self, from: data){
                    let count = vacationDateModel.data.count //몇명인지.
                   
                    for i in 0..<count{
                        var array: [String] = []
                        let num = vacationDateModel.data[i].days.count
                        array.append(vacationDateModel.data[i].userName)
                        //0번째 사람 몇개 휴가 썻는지 갯수.
                        for j in 0..<num{
                        var days = vacationDateModel.data[i].days[j]
                            array.append(vacationDateModel.data[i].vacationType[j])
                            print("유형asdfasdfasdfasdf:",vacationDateModel.data[i].vacationType[j])
                            array.append(vacationDateModel.data[i].days[j])
                            setEvents(var: days)
                        }
                        vacationArray.append(array)
                    }
                    
                    print("vacationArray: ",vacationArray)
                }
            case .failure(let error):
                print("에러에러에러",error)
            }
        }
        
    }
    func getVacationDate(){//팀 연차 현황 가져오는거
        print("getVacationDate 실행")
        vacationArray.removeAll()
        let year = getYear()
        let month = getMonth()
        print("연도 월:\(year)\(month)")
        let url = "https://kconnect.ksmartech.com:8443/vacation/group/\(year)\(month)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        AF.request(request).responseString{ [self] (response) in
            switch response.result{
            case .success(let resData):
                print("resData getVacationDate:" ,resData)
                let decoder = JSONDecoder()
                let data = resData.data(using: .utf8)
                
                if let data = data, let vacationDateModel = try? decoder.decode(VacationDateModel.self, from: data){
                    let count = vacationDateModel.data.count //몇명인지.
                    for i in 0..<count{
                        var array: [String] = []
                        print("이름:",vacationDateModel.data[i].userName)
                        let num = vacationDateModel.data[i].days.count
                        array.append(vacationDateModel.data[i].userName)
                        //0번째 사람 몇개 휴가 썻는지 갯수.
                        for j in 0..<num{
                        var days = vacationDateModel.data[i].days[j]
                            array.append(vacationDateModel.data[i].days[j])
                            array.append(vacationDateModel.data[i].vacationType[j])
                            setEvents(var: days)
                        print("유형asdfasdfasdfasdf:",vacationDateModel.data[i].vacationType[j])
                        }
                        vacationArray.append(array)
                    }
                }
            case .failure(let error):
                print("에러에러에러",error)
            }
        }
        
    }
    func getVacationList(){//팀 연차 갯수 몇개 남았는지 확인
        print("getVacationList 실행")
        let year = getYear()
        let url = "https://kconnect.ksmartech.com:8443/vacation/group/days/\(year)?page=0&size=30"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.headers = APIManager.getAPIHeader()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        AF.request(request).responseString{ [self] (response) in
            switch response.result{
            case .success(let resData):
                print("resData getVacationList:" ,resData)
                let decoder = JSONDecoder()
                let data = resData.data(using: .utf8)
                if let data = data, let vacationListModel = try? decoder.decode(VacationListModel.self, from: data){
                    let count = vacationListModel.data.content.count
                    for i in 0..<count{
                        nameTableCell.append(vacationListModel.data.content[i].userName)
                        totalTableCell.append(String(vacationListModel.data.content[i].totalDays))
                        usedTableCell.append(String(vacationListModel.data.content[i].usedDays))
                    }
                    vacationTable.reloadData()
                }
            case .failure(let error):
                print("에러에러에러",error)
            }
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){//날짜 선택했을때 실행  //
        print("func calendar didSelect")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        print(formatter.string(from: date) + "선택됨")
        var selectDate = formatter.string(from: date)
        var arrayList:[[String]] = [[]]
        for i in 0..<dates.count{
            if dates[i] == date{
                print("이벤트 있는 날짜임. 선택날: \(selectDate)")
                for i in 0..<vacationArray.count{
                    for j in 0..<vacationArray[i].count{
                        print("->",vacationArray[i][j])
                        if vacationArray[i][j] == selectDate{
                            print("선택날짜 , 휴가일자 똑같은거 찾음")//찾았으니까 여기서 이제 새로운 배열에 저장해서 새로운 페이지?(팝업에 전달)
                            var arrayDate:[String] = []
                            arrayDate.append(vacationArray[i][0])
                            arrayDate.append(vacationArray[i][j-1])
                            arrayDate.append(vacationArray[i][j])
                            arrayList.append(arrayDate)
                        }
                    }
                }
                //for문 다 돌고 선택날짜에 휴가정보를 배열에 저장이 끝났으면 여기서 이제 페이지 이동
                print("저정된 정보: ",arrayList)
                print("저정된 정보: ",arrayList.count)
                UserDefaults.standard.set(arrayList.count, forKey: "arrayListCount")
                for i in 1..<arrayList.count{
                    for j in 0...2{
                        print("값:",arrayList[i][j])
                        if j == 0 { //이름
                            UserDefaults.standard.set(arrayList[i][j], forKey: "arrayListName\(i)")
                        }else if j == 1 {//유형
                            UserDefaults.standard.set(arrayList[i][j], forKey: "arrayListType\(i)")
                        }else {//날짜
                            UserDefaults.standard.set(arrayList[i][j], forKey: "arrayListDate\(i)")
                        }
                    }
                }
                let storyboard = UIStoryboard(name: "EmployeeStoryboard", bundle: nil)
                let settingBoard = storyboard.instantiateViewController(withIdentifier: "EmployeeVacationInfoLeader")
                self.present(settingBoard, animated: true, completion: nil)
                break
            }
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) { //달력 넘겼을때 이벤트
        print("func calendarCurrentPageDidChange")
        dates.removeAll()
        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        let year = Calendar.current.component(.year, from: currentPageDate)
        getVacationDate(var: String(year),var: String(month))
    }
    func setEvents(var days : String){ //이벤트 설정
        print("func setEvents")
        print("setEvents days: ", days)
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyyMMdd"
        let startDate = dfMatter.date(from: days)
        let endDate = dfMatter.date(from: days)
        dates.append(startDate!)
        dates.append(endDate!)
        calendarView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.dates.contains(date){
            return 1
        }else {
            return 0
        }
    }
    func getYear() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: Date())
        return year
    }
    
    func getMonth() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = formatter.string(from: Date())
        return month
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameTableCell.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TeamCell else {
            return UITableViewCell()
        }
        cell.nameCell.text = nameTableCell[indexPath.row]
        cell.usedCell.text = usedTableCell[indexPath.row]
        cell.totalCell.text = totalTableCell[indexPath.row]
        return cell
    }
    
}

class TeamCell: UITableViewCell{
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var usedCell: UILabel!
    @IBOutlet weak var totalCell: UILabel!
}

