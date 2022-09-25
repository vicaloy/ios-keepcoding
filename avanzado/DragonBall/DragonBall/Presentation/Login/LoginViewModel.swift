//
//  LoginViewModel.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/9/22.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func onLoginButtonTap(user: String, password: String)
}

class LoginViewModel {
    private let keyChain = KeyChainStore()
    private weak var viewDelegate: LoginViewProtocol?
    
    init(viewDelegate: LoginViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    private func onLoginSuccessful(token: String?){
        executeUserInterfaceTask {
            self.viewDelegate?.onNavigateHome()
        }
        guard let data = token?.data(using: .utf8) else { return }
        self.keyChain.save(data: data, service: KeyChainConstant.service, account: KeyChainConstant.loginTokenAccount)
    }
    
    private func onLoginFailure(){
        executeUserInterfaceTask {
            self.viewDelegate?.onLoading(loading: false)
            self.viewDelegate?.onShowAlert(title: "Try again", message: "Something was wrong", action: "Accept")
        }
    }
    
    private func onLogin(user: String, password: String){
        executeUserInterfaceTask {
            self.viewDelegate?.onLoading(loading: true)
        }
        
        let loginService = LoginService(user: user, password: password)
        loginService.execute(){ token, error in
            switch (error as? ServiceError){
            case .none:
                self.onLoginSuccessful(token: token)
            case .some(.malformedURL), .some(.emptyResponse), .some(.statusCode), .some(.unknown), .some(.decodingFailed), .some(.requestParams):
                self.onLoginFailure()
            }
        }
    }
    
}

extension LoginViewModel: LoginViewModelProtocol {

    func onLoginButtonTap(user: String, password: String) {
        onLogin(user: user, password: password)
    }
}
