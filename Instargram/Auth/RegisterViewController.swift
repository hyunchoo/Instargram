//
//  RegisterViewController.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/04.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



class RegisterViewController: UIViewController {
    var ref: DocumentReference? = nil
//MARK: - IBoutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var NicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
//MARK: - Properties
    var isValidEmails = false
    var isValidName = false
    
    var isValidNickname = false
    var isValidPassword = false
    
    
//MARK: - LifeCyce
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - IBAction
    
    @IBAction func registerButtonTap(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let nickname = NicknameTextField.text ?? ""
        let username = nameTextField.text ?? ""
    let credentails = AuthCredentials(email: email, password: password, fullname: nickname, username: username)
        AuthService.registerUser(withCredential: credentails) { error in
            print(error)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
                    
                    
                }
            
            
        }
    
    
