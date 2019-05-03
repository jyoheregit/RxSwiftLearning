//
//  LoginViewModel.swift
//  RxSwiftProject
//
//  Created by Joe on 02/05/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    // Inputs
    let usernameText = PublishRelay<String>()
    let passwordText = PublishRelay<String>()
    let loginTap = PublishRelay<Void>()
    
    // Outputs
    let loginEnabled : Observable<Bool>
    let result : Observable<String>
    let loginTitle : Observable<String>
    
    init(loginService : LoginService = LoginService()) {
        
        let usernameAndPassword = Observable
            .combineLatest(usernameText, passwordText)
    
        result = loginTap
            .withLatestFrom(usernameAndPassword)
            .flatMapLatest { loginService.login(username: $0, password: $1) }
        
        let isLoading = Observable
            .merge(
                loginTap.map { true },
                result.map {_ in false }
            )
            .debug()
        
        loginTitle = isLoading.map { loading in
            print(loading)
            return loading ? "Loading" : "Login"
        }
        
        loginEnabled = Observable.merge(
            usernameAndPassword.map { $0.count > 0 && $1.count > 0 },
            isLoading.map(!))
            .startWith(false)
    }
}
