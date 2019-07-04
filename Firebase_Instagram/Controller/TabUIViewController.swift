import UIKit

class TabUIViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true

        navigationStufs()
    }
    func navigationStufs() {
        // 1
        let leftLogoutBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TabUIViewController.logoutTapped))
        
        
        
        // 2
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(TabUIViewController.addTapped))
        // 3
        self.navigationItem.setLeftBarButtonItems([leftLogoutBarButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem], animated: true)
        
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
        //label.backgroundColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        label.text = "Instagram"
        label.numberOfLines = 2
        label.textColor = .black
        label.sizeToFit()
        label.textAlignment = .center
        
        self.navigationItem.titleView = label
    }
    
    @objc func logoutTapped() {
        print("LogoutTapped")
        navigationController!.popViewController(animated: true)
    }
    @objc func addTapped(){
        print("addTapped")
//        let viewController: ThirdTabbBar = self.storyboard!.instantiateViewController(withIdentifier: "ThirdTabbBar") as! ThirdTabbBar
//        
//        self.navigationController!.pushViewController(ThirdTabbBar(), animated: true)
    }


}
