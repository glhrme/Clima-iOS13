//
//  WeatherManager.swift
//  Clima
//
//  Created by Guilherme de Assis dos Santos on 13/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=131037fa50dd68fb498c5a4c9b290db9&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(self.weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1- Criar uma url
        if let url = URL(string: urlString) {
            //Criar uma sessao
            let session = URLSession(configuration: .default)
            
            //Criar a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //Inciar a task
            
            task.resume()
        }
    }
    
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherData.self, from: weatherData)
            print(data)
        } catch {
            print(error)
        }
    }
    
    
    
    
}
