//
//  lab5App.swift
//  lab5
//
//  Created by UrdenVM on 25.02.2026.
//

import SwiftUI
internal import Combine

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(listViewModel())
        }
    }
}

class listViewModel: ObservableObject  {
    let url = URL(string: "https://www.dnd5eapi.co/api/2014/spells?level=1")
    let session = URLSession.shared
    @Published var someElements:[ElementData]? = nil
    
    func getElements () async throws {
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)
        if ((response as? HTTPURLResponse)!.statusCode != 200) {
            print("Ошибка. Status: \((response as? HTTPURLResponse)!.statusCode)")
            throw NetworkErrors.serverError(statusCode: (response as? HTTPURLResponse)!.statusCode)
        }
        do {
            let repos = try JSONDecoder().decode(ApiResponse.self, from: data)
            someElements = repos.results // получение элементов
        }
        catch {
            someElements = []
            throw NetworkErrors.invalidData
        }
    }
}

/*
 class listViewModel: ObservableObject  {
     let url = URL(string: "https://api.github.com/users/OlegTerV/repos")
     let session = URLSession.shared
     @Published var someElements:[ElementData]? = nil
     
     func getElements () async throws {
         var request = URLRequest(url: url!)
         request.httpMethod = "GET"

         let (data, response) = try await URLSession.shared.data(for: request)
         if !(200...299).contains((response as? HTTPURLResponse)!.statusCode) {
             print("Ошибка. Status: \((response as? HTTPURLResponse)!.statusCode)")
             throw NetworkErrors.serverError(statusCode: (response as? HTTPURLResponse)!.statusCode)
             //throw NSError(domain: "Ошибка. Status: \((response as? HTTPURLResponse)!.statusCode)", code: 0)
         }
         do {
             let repos = try JSONDecoder().decode([ElementData].self, from: data)
             someElements = repos //main actor
         }
         catch {
             someElements = []
             throw NetworkErrors.invalidData
         }
     }
 }
*/

enum NetworkErrors: Error {
    case serverError(statusCode: Int)
    case invalidData
    case someError
    
    func errorText() -> String {
        switch self {
            case .invalidData:
                return "Данные с API не соответствуют модели"
            case .serverError(let statusCode):
                return "Статус запроса \(statusCode)"
            case .someError:
                return "Неизестная ошибка"
            default:
                return "Неизестная ошибка"
        }
    }
}

