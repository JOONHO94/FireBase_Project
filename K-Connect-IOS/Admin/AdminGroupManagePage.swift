//
//  AdminGroupManagePage.swift
//  K-Connect-IOS
//
//  Created by 최준호 on 2022/02/18.
//

import UIKit
import Alamofire

class AdminGroupManagePage: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var TableView_group: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://kconnect.ksmartech.com:8443/admin/totalCount"
        let header = APIManager.getAPIHeader()
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header)//["Content-Type":"application/json", "Accept":"application/json"]   //
                    .validate(statusCode: 200..<300)
                    .responseJSON { (json) in
                        //여기서 가져온 데이터를 자유롭게 활용하세요.
                        print("Test", json)
                    }
        
        TableView_group.delegate = self
        TableView_group.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = TableView_group.dequeueReusableCell(withIdentifier: "AdminCustomCell", for: indexPath) as? AdminCustomCell
        else{
            return UITableViewCell()
        }
        cell.Lb_Group.text = "\(indexPath.row)"
        return cell
    }   //어떤 데이터 인지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click : \(indexPath.row)")
    }
    
    
}
