//
//  StarViewModel.swift
//  StarWar
//
//  Created by Chathuranga Adikari on 2023-09-14.
//

import Foundation
import RxSwift
import RxRelay

class StarViewModel: ObservableObject {
    var starArray = BehaviorSubject(value: [Result]())
    
    var isLoading = false
    var pageLimit = 0
    
    func fetchStarDate (page: Int) {
        let url = URL(string: Environmental.baseUrl + "/?page=\(page)" )
        
        isLoading = true
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            self.isLoading = false
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Star.self, from: data)
                var count = response.count
                self.pageLimit = Int(count ?? 0) / 10
                
                guard let starsDetails = try? self.starArray.value() else { return}
                var oldData = starsDetails
                self.starArray.on(.next(oldData + (response.results ?? [])))
                print("Page Loaded")
                print("page no: \(page)")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func loadRandomImage(id: Int) {
        let url = URL(string: "https://picsum.photos/id/\(id)/221/128" )
        
        isLoading = true
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(String.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
