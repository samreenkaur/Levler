//
//  MenuViewController.swift
//  Levler
//
//  Created by Mohak on 21/09/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBAction func sentInviteButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func RateOurApp(_ sender: Any) {
        openURL(urlStr: "itms-apps://itunes.apple.com/app/co.levler/levler/id1293043752")
    }
    
    @IBAction func logout(_ sender: Any) {
        print("LOGOUT SUCCESS")
        //PFUSer.logout()
        let defaultValues = UserDefaults.standard
        
        defaultValues.set(nil, forKey: "token")
        let token = defaultValues.string(forKey: "token")
        print(token as Any)
        print("LOGIN AGAIN")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Login = storyboard.instantiateViewController(withIdentifier: "viewController")
        self.present(Login, animated: true, completion: nil)
       /*  let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
      //  window?.rootViewController = loginViewController
        loginViewController.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
 */
       
    }
    
    
    func openURL(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

