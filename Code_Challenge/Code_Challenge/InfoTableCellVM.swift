//
//  InfoTableCellVM.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

struct InfoCellSetupModel {
    var title: String = ""
    var description = ""
    var imageURL: String = ""
}

protocol InfoTableCellVMRepresentable {
    // Output
    var cellSetupModel: InfoCellSetupModel { get }
}

class InfoTableCellVM: InfoTableCellVMRepresentable {
    var cellSetupModel: InfoCellSetupModel = InfoCellSetupModel()
    
    init(info: Row) {
        cellSetupModel.title = info.title ?? ""
        cellSetupModel.description = info.description ?? ""
        cellSetupModel.imageURL = info.imageHref ?? ""
    }
}
