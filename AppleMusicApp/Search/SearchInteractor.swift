//
//  SearchInteractor.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 06.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .getTracks(let searchText):
            print("interactor .getTracks")
            presenter?.presentData(response: .presentFooterView)
            NetworkService.shared.fetchTracks(searchText: searchText) { [weak self] result in
                switch result {
                case .success(let trackModel):
                    self?.presenter?.presentData(response: .presentTracks(trackModel: trackModel))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
