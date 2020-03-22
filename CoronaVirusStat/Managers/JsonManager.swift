//
//  JsonManager.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import UIKit

class JsonManager {
    
    static let shared = JsonManager()
    
    func getData <T: Decodable> (view: UIViewController,
                                 link: String,
                                 typeData: T.Type,
                                 complition: @escaping (T) -> Void ) {
        
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { AlertController.shared.showErrorAlert(view: view, titleAlert: "Connection Error", messageAlert: error.localizedDescription) }
            
            guard let data = data else { return }
            
            do {
                let decodeData = try JSONDecoder().decode(typeData.self, from: data)
                
                DispatchQueue.main.async {
                    complition(decodeData)
                }
                
            } catch let errorDecode as NSError {
                AlertController.shared.showErrorAlert(view: view, titleAlert: "Convert data error", messageAlert: errorDecode.localizedDescription)
            }
            
            } .resume()
    }
}

