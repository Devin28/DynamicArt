//
//  UploadImageViewController.swift
//  safeApp
//
//  Created by HGPMAC82 on 7/24/19.
//  Copyright © 2019 HGPMAC82. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class UploadImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func importImage(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            myImageView.image  = image
        }
            //Error Message
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        self.uploadArt(myImageView.image!) { url in
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges {error in
                    if (error != nil) {
                      print("User display name changed")
                        
                        self.saveProfile(profileImageUrl: url!) {success in
                            if success {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    } else {
                        print ("Error: \(error?.localizedDescription)")
                    }
                }
            } else {
                // Error unable to upload profile image
                
            }
        }
    }
            
            
    func saveProfile(profileImageUrl: URL, completion: @escaping (( _ success: Bool)->() )) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "photoURL": profileImageUrl.absoluteString
        ] as [String: Any]
        
        databaseRef.setValue(userObject) {error, ref in
            completion(error == nil)
        }
    }

    
    
    
    func uploadArt(_ image: UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child ("user/\(uid)/art")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/ jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error  in
            if error == nil, metaData != nil {
                storageRef.downloadURL { url,
                    error in
                        completion(url)

                }
            } else {
                //failed
                completion(nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
