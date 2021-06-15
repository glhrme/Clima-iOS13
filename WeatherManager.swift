//
//  WeatherManager.swift
//  Clima
//
//  Created by Guilherme de Assis dos Santos on 13/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func onChangeWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=131037fa50dd68fb498c5a4c9b290db9&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(self.weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(self.weatherURL)&lat=\(lat)&lon=\(lon)"
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
                    guard let weather = self.parseJSON(weatherData: safeData) else { return }
                    delegate?.onChangeWeather(weather: weather)
                }
            }
            
            //Inciar a task
            
            task.resume()
        }
    }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherData.self, from: weatherData)
            let id = data.weather[0].id
            let temp = data.main.temp
            let name = data.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            return nil
        }
    }
    
    
    
    
    
    
}
