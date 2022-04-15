//
//  EmployeeVacationInfoLeader.swift
//  K-Connect-IOS
//
//  Created by 이준협 on 2022/03/07.
//

import Foundation
import UIKit

class NotificationController : UIViewController, UITableViewDataSource, UITableViewDelegate{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

      

    }
    
    @IBAction func GoHome_Btn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)   //네비게이션으로 보내거나 그냥 보내면 탭바 네비게이션 다 사라짐
    }
    
    @objc func dismissClickBtn(){
        print("x 눌림")
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? InfoCell else{
            return UITableViewCell()
        }
        cell.dateCell.text = "3"
     return cell
    }
}
class InfoCell: UITableViewCell{
    @IBOutlet weak var dateCell: UILabel!
   
}
