//
//  SplashViewModel.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import Foundation

protocol SplashViewModelProtocol: AnyObject {
    func onViewsLoaded()
}

class SplashViewModel {
    
    private weak var viewDelegate: SplashViewProtocol?
    private var loadingTime: DispatchTime {
        .now() + .seconds(3)
    }
    
    init(viewDelegate: SplashViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
}

extension SplashViewModel: SplashViewModelProtocol {
    
    func onViewsLoaded() {
        DispatchQueue.main.asyncAfter(deadline: loadingTime) { [viewDelegate] in
            viewDelegate?.navigateToHome()
        }
    }
}
