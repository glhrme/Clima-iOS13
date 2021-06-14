//
//  WeatherData.swift
//  Clima
//
//  Created by Guilherme de Assis dos Santos on 14/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let base: String
    let main: MainWeather
    let weather: [Weather]
}

struct MainWeather: Decodable {
    let temp: Double
    let pressure: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
