//
//  SendInviteViewController.swift
//  Levler
//
//  Created by Mohak on 21/09/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import Alamofire
class SendInviteViewController: UIViewController {

    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var customerContact: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var locationName: UILabel!
    
    @IBAction func buttonTapped(_ sender: Any) {
        if customerName.text == ""
        {
            label.isHidden = false
            label.text = "Name field can't be empty."
      
        }
        else if customerContact.text == ""
        {
            label.isHidden = false

            label.text = "Contact field can't be empty."
        }
        else if (customerContact.text?.characters.count)!<10
        {
            label.isHidden = false

            label.text = "Contact must contain 10 digits."
       
        }
        else{
            label.isHidden = true
            invite()
       
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        customerName.underlined()
        customerContact.underlined()
        label.isHidden = true
        self.hideKeyboardWhenTappedAround()
        let defaultValues = UserDefaults.standard
        
        let location_name = defaultValues.string(forKey: "location_name")
        locationName.text = location_name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func SendingMore(){
        let homeViewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //self.navigationController?.pushViewController(homeViewController, animated: true)
        let navController: UINavigationController = UINavigationController(rootViewController: homeViewController)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UIApplication.shared.keyWindow?.rootViewController = navController
        
        self.dismiss(animated: false, completion: nil)
        
    }
    func invite()
    {
        
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        let params: [String: String] = ["name": customerName.text!, "phone": customerContact.text!]
        request("https://app.levler.co/api/v1/employe_invites", method: .post, parameters: params , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Invite Sent: \(response.result)")
            self.customerName.text = ""
            self.customerContact.text = ""

            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                 let msg = json["message"] as! String
              //  defaultValue.set(msg, forKey: "message")
                let alert = UIAlertController(title: "Invite Sent \(msg)", message: " Do you want to send again?", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler:{ (action) in
                    //execute some code when this option is selected
                    self.SendingMore()
                }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
               // self.SendingMore()
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
            case .failure:
                print("error")
                let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
        }
    }
}
