//
//  InfoListControllerVM.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

struct InfoModel {
    let title: String
    let cellViewModels: [InfoTableCellVMRepresentable]
    let rows: [Row]
}

protocol InfoListVMRepresentable {
    var reloadTable: () -> Void { get set }
    var rowCount : Int { get }
    
    var showAlert: (String) -> Void { get set }
    var showLoader: (Bool, String?) -> Void { get set }
    
    func viewWillAppear()
    func getCellViewModel(for indexPath: IndexPath) -> InfoTableCellVMRepresentable?
    func getRowCount() -> Int
    func getTitle() -> String
}

class InfoListControllerVM: InfoListVMRepresentable {
    
    private var infoModel : InfoModel?
    private let infoServiceRequest: InfoServiceRequestType
    
    var reloadTable: () -> Void = { }
    var rowCount : Int {
        return infoModel?.rows.count ?? 0
    }
    var showAlert: (String) -> Void  = { _ in }
    var showLoader: (Bool, String?) -> Void = { _,_  in }
    
    init(infoServiceRequest: InfoServiceRequestType) {
        self.infoServiceRequest = infoServiceRequest
    }
    
    func viewWillAppear() {
        getInfo()
    }
    
    private func getInfo() {
        showLoader(true, "Fetching Info...")
        infoServiceRequest.getAllInformations(completion: { [weak self] (information, error) in
            guard let info = information, error == nil else {
                self?.showAlert(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard let self = self else { return }
            self.infoModel = self.getsectionModels(info:info)
            self.reloadTable()
            self.showLoader(false, nil)
        })
    }
    
    private func getsectionModels(info: Information) -> InfoModel {
        let cellVMs : [InfoTableCellVMRepresentable] = info.rows?.map({
            return InfoTableCellVM(info: $0)
        }) ?? []
        let tempSectionModels  = InfoModel(title: info.title ?? "", cellViewModels: cellVMs, rows: info.rows ?? [])
        return tempSectionModels
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> InfoTableCellVMRepresentable? {
        return infoModel?.cellViewModels[indexPath.row]
    }
    
    func getRowCount() -> Int {
        return infoModel?.rows.count ?? 0
    }
    
    func getTitle() -> String {
        return infoModel?.title ?? "No Title"
    }
}
