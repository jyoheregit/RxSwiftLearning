//
//  LoginViewController.swift
//  RxSwiftProject
//
//  Created by Joe on 02/05/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginResult:UILabel!
    
    lazy var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
            // Inputs to ViewModel
            usernameTextField.rx.text.orEmpty
                .bind(to: loginViewModel.usernameText)
                .disposed(by: disposeBag)
        
            passwordTextField.rx.text.orEmpty
                .bind(to: loginViewModel.passwordText)
                .disposed(by: disposeBag)
        
            loginButton.rx.tap
                .bind(to: loginViewModel.loginTap)
                .disposed(by: disposeBag)
        
            // Output from ViewModel
            loginViewModel.loginEnabled
                .bind(to: loginButton.rx.isEnabled)
                .disposed(by: disposeBag)
        
            loginViewModel.loginTitle
                .bind(to: loginButton.rx.title(for: .normal))
                .disposed(by: disposeBag)

            loginViewModel.result
                .bind(to: loginResult.rx.text)
                .disposed(by: disposeBag)
    }
    
}
