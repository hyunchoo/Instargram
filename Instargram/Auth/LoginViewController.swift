//
//  LoginViewController.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/04.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailTextField, passwordTextField, loginButton].forEach {
            $0?.layer.cornerRadius = 10
        }
    }

    @IBAction func emailTextField(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
            
    }
    
    @IBAction func passwordTextField(_ sender: UITextField) {
    
        let text = sender.text ?? ""
        self.password = text
            
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG : Failed to log user in \(error.localizedDescription)")
                return
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        
      
        
    }
    
    
    @IBAction func registerButtonTap(_ sender: UIButton) {
        //화면 전환
        //1.스토리 보드 생성?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //2.뷰컨트롤러를 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        //3.화면전환 메소드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}

