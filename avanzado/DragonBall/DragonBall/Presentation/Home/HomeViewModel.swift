//
//  HomeViewModel.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func onViewsLoaded()
}

class HomeViewModel{
    private let keyChain = KeyChainStore()
    private weak var viewDelegate: HomeViewProtocol?
    
    init(viewDelegate: HomeViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    private func onHerosLoadedSuccessful(heros:[Hero]?){
        executeUserInterfaceTask {
            self.viewDelegate?.onCollectionLoad(heros: heros ?? [])
        }
    }
    
    private func onHerosLoadedFailure(){
        executeUserInterfaceTask {
            self.viewDelegate?.onShowAlert(title: "Try again", message: "Something was wrong", action: "Accept")
        }
    }
    
    private func onHerosLoadCoreData(){
        let heroCoreDataRepo = HeroCoreDataRepository()
        heroCoreDataRepo.fetch{
            heros in
            if (heros?.isEmpty == false){
                self.onHerosLoadedSuccessful(heros: heros)
            }else{
                self.onHerosLoadService()
            }
        }
    }
    
    private func onSaveHerosCoreData(heros: [Hero]? ){
        if(heros?.isEmpty==false){
            let heroCoreDataRepo = HeroCoreDataRepository()
            heroCoreDataRepo.insert(heros: heros!)
        }
        
    }
    
    private func onHerosLoadService(){
        let data = keyChain.read(service: KeyChainConstant.service, account: KeyChainConstant.loginTokenAccount)
        let token = String(decoding: data ?? Data(), as: UTF8.self)
        let heroService = HeroService(nameFilter: "", token: token, service: Service<[Hero]>())
        heroService.execute(){ heros, error in
            switch (error as? ServiceError){
            case .none:
                self.onSaveHerosCoreData(heros: heros)
                self.onHerosLoadedSuccessful(heros: heros)
            case .some(.malformedURL), .some(.emptyResponse), .some(.statusCode), .some(.unknown), .some(.decodingFailed), .some(.requestParams):
                self.onHerosLoadedFailure()
            }
        }
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func onViewsLoaded() {
        self.onHerosLoadCoreData()
    }
    
}
