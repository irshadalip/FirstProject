import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class SideMenuViewController: UIViewController{
    

    @IBOutlet weak var profileImageOut: UIImageView!
    @IBOutlet weak var profileUser: UILabel!
    @IBOutlet weak var loginOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var userID = User["id"] as NSString
        //var facebookProfileUrl = "http://graph.facebook.com/userID)/picture?type=large"
        
//        let url = Auth.auth().currentUser?.photoURL
//        print(url as Any)
//
//        if let data = try? Data(contentsOf: url!){
//            if let image = UIImage(data: data){
//                profileImageOut.image = image
//
//            }
//        }
//        profileUser.text = Auth.auth().currentUser?.displayName
        
        // Do any additional setup after loading the view.InstaClone.
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        if sender.tag == 1{
            self.dismiss(animated: true, completion: nil)
        }
        else if sender.tag == 2{
            
            let text = "Share Action"
            let textToShare = [text]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.message]
            self.present(activityViewController, animated: true, completion: nil)
        }
        else if sender.tag == 3{
            do{
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
                Auth.auth().currentUser?.link(with:credential,completion:nil)
                try! Auth.auth().signOut()
                Auth.auth().signInAnonymously()
                LoginManager().logOut()
                print("Logged Out Successfully")
            }catch{
                print("LogIn Error :-------------- \(error)")
            }

            UserDefaults.standard.set(false, forKey:"login")

            self.dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
            
        }
    }
}
