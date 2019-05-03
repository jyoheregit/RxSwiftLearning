//
//  LoginService.swift
//  RxSwiftProject
//
//  Created by Joe on 02/05/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import Foundation
import RxSwift

class LoginService {
    
    func login(username: String, password : String) -> Observable<String> {
        
        sleep(2)
        
        return Observable<String>.create { observer in
            
            if(username == "ram" && password == "test") {
                observer.onNext("Login Successful")
                observer.onCompleted()
            }
            else {
                observer.onNext("Login Failed")
                observer.onCompleted()
            }
            return Disposables.create {
                
            }
        }
    }
}
