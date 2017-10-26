//
//  SendInviteViewController.swift
//  Levler
//
//  Created by Mohak on 21/09/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import Alamofire
import CountryPicker


class SendInviteViewController: UIViewController, CountryPickerDelegate {

    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var customerContact: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var locationName: UILabel!
    
   // @IBOutlet weak var doePickerButton: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var picker: CountryPicker!
    
    @IBOutlet weak var countryCodeBt: UIButton!
    var isOpen = false
    var codeLabel = ""
    
  /*  @IBAction func donePicker(_ sender: Any) {
        codeLabel = countryCodeBt.currentTitle!
        let codeup = codeLabel.split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
       // print("codeup:")
      //  print(codeup)
      ///  print(codeup[0])
        countryCodeBt.setTitle("\(codeup[0])▾", for: .normal)
        
        doePickerButton.isHidden = true
        picker.isHidden = true
        sendButton.isHidden = false
        isOpen = false
        customerName.isUserInteractionEnabled = true
        customerContact.isUserInteractionEnabled = true
    }*/
    @IBAction func countryCodeButton(_ sender: Any) {
        countryCodeVisibility()
       
    }
    
    @IBAction func nameTF(_ sender: Any) {
        picker.isHidden = true
        isOpen = true
        sendButton.isHidden = false
        countryCodeVisibility()
    }
    
    @IBAction func contactTF(_ sender: Any) {
        picker.isHidden = true
        isOpen = true
        sendButton.isHidden = false
        countryCodeVisibility()
    }
    func countryCodeVisibility(){
        if (!isOpen)
        {
            codeLabel = countryCodeBt.currentTitle!
            let codedown = codeLabel.split(separator: "▾", maxSplits: 2, omittingEmptySubsequences: true)
            let codeup = codedown[0].split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
            let codelabel = codeup[0]
            // print("coddown:")
            // print(codedown)
            // print(codedown[0])
            
            countryCodeBt.setTitle("\(codelabel)▴", for: .normal)
            //  customerName.isUserInteractionEnabled = false
            // customerContact.isUserInteractionEnabled = false
            isOpen = true
            //  doePickerButton.isHidden = false
            picker.isHidden = false
            //sendButton.isHidden = true
            let locale = Locale.current
            let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
            //init Picker
            picker.countryPickerDelegate = self
            picker.showPhoneNumbers = true
            picker.setCountry(code!)
            
        }
        else if isOpen {
            codeLabel = countryCodeBt.currentTitle!
            let codeup = codeLabel.split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
           let codedown = codeup[0].split(separator: "▾", maxSplits: 2, omittingEmptySubsequences: true)
            let codelabel = codedown[0]
            // print("codeup:")
            //  print(codeup)
            ///  print(codeup[0])
            countryCodeBt.setTitle("\(codelabel)▾", for: .normal)
            customerName.isUserInteractionEnabled = true
            customerContact.isUserInteractionEnabled = true
            isOpen = false
            // doePickerButton.isHidden = true
            picker.isHidden = true
            sendButton.isHidden = false
            
        }
    }
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
      //  doePickerButton.isHidden = true
        picker.isHidden = true
        sendButton.isHidden = false
        //customerName.underlined()
       // customerContact.underlined()
        
        label.isHidden = true
        self.hideKeyboardWhenTappedAround()
        let defaultValues = UserDefaults.standard
        
        let location_name = defaultValues.string(forKey: "location_name")
        locationName.text = location_name
        UITextField.appearance().tintColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
        //countryCodeBt.layer.borderWidth = 1.0
     //   UITextField.appearance().layer.borderColor = UIColor(red: 96/255, green: 189/255, blue: 106/255, alpha: 1.0).cgColor
        
    
    
    }
   

    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        
        countryCodeBt.setTitle("\(phoneCode)▴", for: .normal)
        
        
     //   sendButton.isHidden = false
     // picker.isHidden = true
        //customerContact.text = phoneCode
       
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
        
        codeLabel = countryCodeBt.currentTitle!
        let code1 = codeLabel.split(separator: "+", maxSplits: 2, omittingEmptySubsequences: true)
        print("cod1:")
        print(code1)
        let codeup = code1[0].split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
        print("codup:")
        print(codeup)
        let codedown = codeup[0].split(separator: "▾", maxSplits: 2, omittingEmptySubsequences: true)
        print("coddown:")
        print(codedown)
        let code2 = codedown[0]
         print("code2")
        print(code2)
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        let params: [String: String] = ["name": customerName.text!, "phone": customerContact.text! , "country_code": String(code2)]
        print(codeLabel)
        request("https://app.levler.co/api/v1/employe_invites", method: .post, parameters: params , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Invite Sent: \(response.result)")
            self.customerName.text = ""
            self.customerContact.text = ""

            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let msg = json["message"] as? String {
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
                        else
                    {
                        let alert = UIAlertController(title: "Error", message: "No invite links are there.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)

                    }
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
