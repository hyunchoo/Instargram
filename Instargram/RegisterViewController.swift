//
//  RegisterViewController.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/04.
//

import UIKit

class RegisterViewController: UIViewController {
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
    }
    


}
