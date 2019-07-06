import UIKit
import FirebaseAuth
import Firebase
import SideMenu


protocol ImageGs {
    func imageGs(text: String, image: UIImage)
}

class FirstTabbBar: UIViewController, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource {

    var listOfData = [Model]()
    
    var cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
    
    let db = Firestore.firestore()
    
    var DelegateData: ImageGs?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        
  
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        readData()

        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        readData()
        tableView.reloadData()
    }
    
    @IBAction func manuBarButton(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
}

//MARK:- IMAGE-FETCH extension
extension FirstTabbBar{
    
    func readData() {
        self.listOfData.removeAll()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = Model()
                    newitem.post = (document.data()["first"] as! String)
                    
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "mems/\(document.documentID).jpg")
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            newitem.img  = UIImage(data: data)!
                        }
                    })
                    self.listOfData.append(newitem)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    self.tableView.reloadData()
                    //print(self.captions)
                    print("Data Print:- \(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

//MARK:- TABLEVIEW extension
extension FirstTabbBar{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.postLabelOut.text = listOfData[indexPath.row].post
        cell.ImageOfCell.image = listOfData[indexPath.row].img
        cell.profileout.layer.cornerRadius = cell.profileout.frame.size.height/2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController: imageViewController = self.storyboard!.instantiateViewController(withIdentifier: "imageViewController") as! imageViewController
        
        viewController.story = listOfData[indexPath.row].post
        viewController.imageOne = listOfData[indexPath.row].img
        
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //return 400
    }
}
//MARK:- COLLECTIONVIEW extension
extension FirstTabbBar{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCollectionViewCell", for: indexPath) as! RoundCollectionViewCell
        return cell
    }
}
