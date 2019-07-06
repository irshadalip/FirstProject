import UIKit
import FirebaseAuth
import Firebase


class ThirdTabbBar: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textPost: UITextView!
    
    let db = Firestore.firestore()
    var postId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func addImage(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        print("Share TAbbed")
        uploadStory()
        uploadImage()
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        print("Cancel TAbbed")
    
    }
    
    func uploadStory() {
        var ref: DocumentReference? = nil
        
        // Add a new document with a generated ID
        ref = db.collection("users").addDocument(data: [ "first": "\(textPost.text ?? "")",]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        postId = ref!.documentID
    }
    func uploadImage(){
        
        let uploadRef = Storage.storage().reference(withPath: "mems/\(postId).jpg")
        guard let imageDtat = imageView.image?.jpegData(compressionQuality: 0.75) else {return}
        let uploadMetaData = StorageMetadata.init()
        uploadMetaData.contentType = "image/jpeg"
        
        uploadRef.putData(imageDtat, metadata: uploadMetaData) {(downloadMetadata, error) in }
        if Error.self != nil {
            print("uploaded photo")
            
        } else {
            print("uploaded Error")
        }
    }
    
}
