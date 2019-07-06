import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate{

    @IBOutlet weak var backtOutView: UIView!
    
    var loginStatus : Bool = false
    var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true

        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        loginButton.delegate = self
        loginButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 50)
    
        if UserDefaults.standard.bool(forKey: "login") == true{
            let viewController:TabUIViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabUIViewController") as! TabUIViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        createGradientLayer()
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
       
        if let error = error {
            print(error.localizedDescription)
            return
        }
        else{
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("ERROR")
                    
                    return
                }
            }
        }
        
        UserDefaults.standard.set(true, forKey: "login")
        let viewController:TabUIViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabUIViewController") as! TabUIViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        UserDefaults.standard.set(false, forKey: "login")
        print("Logout")
    }
    
    func createGradientLayer() {

        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        backtOutView.layer.addSublayer(gradientLayer)
    }
}
