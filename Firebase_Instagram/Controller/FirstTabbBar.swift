import UIKit
import FirebaseAuth
import Firebase




class FirstTabbBar: UIViewController, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource {

    var listOfData = [Model]()
    
    var cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
    
    let db = Firestore.firestore()
    

//    @IBOutlet weak var fiveButton: UIButton!
//    @IBOutlet weak var firstButton: UIButton!
//    @IBOutlet weak var secondButton: UIButton!
//    @IBOutlet weak var thirdButton: UIButton!
//    @IBOutlet weak var fourthButton: UIButton!
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
        
        UIUpdate()

    }
    override func viewWillAppear(_ animated: Bool) {
        readData()
        tableView.reloadData()
        
        
    }
    
   
    //==========
    func getCollection_readData()
    {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let newitem = Model()
                    print("\(document.documentID) => \(document.data())")
                    
                    newitem.post = (document.data()["first"] as! String)
                    //self.listOfData.append(newitem)

                        let storeRef = Storage.storage().reference(withPath: "mems/\(document.documentID).jpg")
                        storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if let error = error {
                                print("ERROR-----------,\(error)")
                                
                            }
                            if let data = data{
                                newitem.img = UIImage(data: data)
                                
                            }
                            
                        }
                   self.listOfData.append(newitem)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    
                        print("Data Print:- \(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
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

extension FirstTabbBar{
    
        func getImage() {
            db.collection("users").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                }
                else {
                    for document in querySnapshot!.documents {
                        
                        // feching data
                        
                       
                        
                    }
                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfData.count
        
        print(listOfData)
        print(listOfData.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        cell.postLabelOut.text = listOfData[indexPath.row].post
        cell.ImageOfCell.image = listOfData[indexPath.row].img
        //=====
    
        //=====
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 350
    }
    func UIUpdate(){
//        firstButton.clipsToBounds = true;
//        firstButton.layer.cornerRadius = firstButton.layer.frame.size.width/2;
//        secondButton.clipsToBounds = true;
//        secondButton.layer.cornerRadius = firstButton.layer.frame.size.width/2;
//        thirdButton.clipsToBounds = true;
//        thirdButton.layer.cornerRadius = firstButton.layer.frame.size.width/2;
//        fourthButton.clipsToBounds = true;
//        fourthButton.layer.cornerRadius = firstButton.layer.frame.size.width/2;
//        fiveButton.clipsToBounds = true;
//        fiveButton.layer.cornerRadius = fiveButton.layer.frame.size.width/2;
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCollectionViewCell", for: indexPath) as! RoundCollectionViewCell
        //        cell.buttonView = buttonView[indexPath.row]
        
        return cell
    }
}


//
//func readData()
//{
//    db.collection("users").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//                let newitem = Model()
//                print("\(document.documentID) => \(document.data())")
//
//
//                newitem.post = (document.data()["first"] as! String)
//                self.listOfData.append(newitem)
//
//
//                //self.newitem.post.append(document.data()["first"] as! String)
//
//
//            }
//        }
//    }
//}
