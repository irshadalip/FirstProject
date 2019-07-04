//
//  SideMenuViewController.swift
//  Firebase_Instagram
//
//  Created by Irshadali Palsaniya on 04/07/19.
//  Copyright © 2019 Irshadali Palsaniya. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class SideMenuViewController: UIViewController {
    

    @IBOutlet weak var loginOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        if sender.tag == 1{
            
        }
        else if sender.tag == 2{
            
        }
        else if sender.tag == 3{
//            do{
//                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
//                Auth.auth().currentUser?.link(with:credential,completion:nil)
//                try! Auth.auth().signOut()
//                Auth.auth().signInAnonymously()
//                LoginManager().logOut()
//                print("Logged Out Successfully")
//            }catch{
//                print("User Sign Out Error : \(error)")
//            }
//
//            UserDefaults.standard.set(false, forKey:"login")
//
//            self.dismiss(animated: true, completion: nil)
//            navigationController?.popToRootViewController(animated: true)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = vc
            
        }
    }
    
}
