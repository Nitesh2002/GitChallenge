//
//  InfoWebserviceReequestsStub.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//


import Foundation

struct InfoWebserviceReequestsStub: InfoServiceRequestType {
    func getAllInformations(completion: @escaping GetAllInfoResponse) -> URLSessionDataTask? {
        completion(MockDataSet().info, nil)
        return nil
    }
}

struct MockDataSet {
    private (set) var info : Information?
    
    init() {
        info = getMockFacts()
    }
    
    private func getMockFacts() -> Information {
        let rows = [Row(title: "one", description: "Desc1", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"),Row(title: "two", description: "Desc2", imageHref: "")]
        let title = "Facts"
        return Information(title: title, rows: rows)
    }
}
