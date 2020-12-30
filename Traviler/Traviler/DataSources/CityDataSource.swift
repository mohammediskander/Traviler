//
//  CityDataSource.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 22/12/2020.
//

import Foundation

protocol CityDataSourceDelegate: AnyObject {
    func dataLoaded()
}

class CityDataSource: NSObject {
    
    static var shared: CityDataSource = .init()
    weak var delegate: CityDataSourceDelegate?
    
    var data: [City] = []
    
    
    
    override init() {
        super.init()
        
        self.fetch()
    }
    
    init(session configuration: URLSessionConfiguration) {
        super.init()
        
        session = URLSession(configuration: configuration)
        
        self.fetch()
    }
    
    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetch(){
        self.session.fetch(CountriesAPI.getCitiesIn(country: "SA"), decode: Cities.self) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.data = response.cities
            case .failure(let error):
                print("ERR::\(error)")
            }
        }
    }
    
    func filtered(with text: String?) -> [City] {
        
        guard let text = text, text != "" else { return self.data }
        
        return self.data.filter {
            $0.name.lowercased().contains(text.lowercased())
        }
    }
}

struct Cities: Codable {
    var name: String
    var code: String
    var flag: String
    var cities: [City]
}

struct Countries: Codable {
    var page, pages, limit, length: Int
    var countries: [Country]
}

struct Country: Codable {
    var flag: String
    var name, code: String
}
