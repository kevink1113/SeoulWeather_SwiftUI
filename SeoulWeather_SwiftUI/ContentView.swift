//
//  ContentView.swift
//  Weather
//
//  Created by 강상원 on 2020/08/06.
//  Copyright © 2020 강상원. All rights reserved.
//

import SwiftUI
import Combine
 /*
 struct Weather: Decodable {
     var main: String
     var description: String
 }
 
struct WeatherResponse: Decodable {
    let weather: [Weather]
}*/
 
struct ContentView: View {
    @State private var city = "Loading..."
    @State private var description = "--"
    @State private var temp = 0
    @State private var t_max = 0
    @State private var t_min = 0
    @State private var t_feel = 0
    @State private var humidity = 0
    @State private var sunrise = "-:--"
    @State private var sunset = "-:--"
    @State private var iconData = "loading"
    @State private var cloudPer = 0
    
    @State private var weatherStatus = "01"
    
    @State private var daynight = "d"
    
    @State private var color = ""
    
    /*
    var cloudPP: Main?
    var clouds: Cloud
    */
    
    let weatherIcons = [
        "01d": "sun.max.fill",
        "02d": "cloud.sun.fill",
        "03d": "cloud.fill",
        "04d": "smoke.fill",
        "09d": "cloud.drizzle.fill",
        "10d": "cloud.rain.fill",
        "11d": "cloud.bolt.rain.fill",
        "13d": "snow",
        "50d": "cloud.fog.fill",
        "01n": "moon.stars.fill",
        "02n": "cloud.moon.fill",
        "03n": "cloud.fill",
        "04n": "smoke.fill",
        "09n": "cloud.drizzle.fill",
        "10n": "cloud.rain.fill",
        "11n": "cloud.bolt.rain.fill",
        "13n": "snow",
        "50n": "cloud.fog.fill",
        "loading" : "goforward",
        "wind" : "wind",
        "sunrise" : "sunrise.fill",
        "sunset" : "sunset.fill",
    ]
    
    
     var body: some View {
        
        
        ZStack {
            if(weatherStatus == "01d") {
                //Color.gray.edgesIgnoringSafeArea(.all)
                //Color.UIColor.brown.
                Color(red: 54 / 255, green: 144 / 255, blue: 218 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "02d") {
                Color(red: 145 / 255, green: 174 / 255, blue: 185 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "03d") {
                Color(red: 145 / 255, green: 145 / 255, blue: 145 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "04d") {
                 Color(red: 130 / 255, green: 130 / 255, blue: 130 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "09d" || weatherStatus == "10d" || weatherStatus == "11d") {
                 Color(red: 90 / 255, green: 90 / 255, blue: 90 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "13d") {
                 Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "50d") {
                Color(red: 90 / 255, green: 90 / 255, blue: 90 / 255).edgesIgnoringSafeArea(.all)
            } else if(weatherStatus == "sunrise" || weatherStatus == "sunset"){
                 Color(red: 218 / 255, green: 103 / 255, blue: 129 / 255).edgesIgnoringSafeArea(.all)
            } else {
                 Color.black.edgesIgnoringSafeArea(.all)
            }
            
            
            
            VStack {
            
                VStack(alignment: .center, spacing: 20) {
                    
                    Text("\(city)")
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                        .onAppear(perform: getWeather)
                    
                    //Text("HAHAHA \(clouds.percentage ?? 10)")
                    
                    Image(systemName: weatherIcons[iconData] ?? "goforward")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFill()
                        .frame(width: 150.0, height: 150.0)
                        .onTapGesture(perform: getWeather)
                    
                    Text("\(description)")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .font(.title)
                        
                    
                    Text("\(temp-273)°")
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 20) {
                        Text("↑\(t_max-273)°")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                        
                        Text("↓\(t_min-273)°")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                        Text("체감 \(t_feel-273)°")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 30.0)
                }
                HStack {
                    VStack(alignment: .leading, spacing: 20){
                        HStack {
                            Image(systemName: "drop.triangle")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 25.0, height: 25.0)
                            Text(" \(humidity)%").foregroundColor(.white)
                        }
                    
                        HStack() {
                            Image(systemName: "sunrise.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 30.0, height: 30.0)
                            Text("\(sunrise)").foregroundColor(.white)
                            Spacer()
                            
                            Image(systemName: "sunset.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 30.0, height: 30.0)
                            Text("\(sunset)").foregroundColor(.white)
                        }
                        HStack {
                            Image(systemName: "cloud.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 25.0, height: 25.0)
                            Text(" \(cloudPer)%").foregroundColor(.white)
                        }
                    }
                    
                    
                    Spacer()
                }////
                
                .padding(30)

                    .background(Color.white.opacity(0.1))
                .cornerRadius(25)
                    .padding(10)
                    
                
            }
        }
        
        //.padding(10.0)
        

     }
    
    
    // -->>>
    
    func utcToSystemTime(time: Int) -> String {
        let fullDate = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let time = formatter.string(from: fullDate)
        return time
    }
    
    
    func getWeather() {
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=[Insert_Your_API_KEY]") else {return}
            
            print("Start API Fetch")
            URLSession.shared.dataTask(with: url){ data, response, error_ in
                if let error = error_ {
                    print("API Request Error: \(error.localizedDescription)")
                } else {
                    if let data = data {
                        do {
                            print("End API Fetch")
                            let weather = try JSONDecoder().decode(Weather.self, from: data)
                            print(weather)
                            //print("HAHAHAHA\(weather.clouds)")
                            print("HAHAHAHA\(weather.clouds!)")
                            print(weather.main?.feels_like ?? "loading")
                            print(weather.main?.humidity ?? "loading")
                            
                            print(weather.weather?.description.description ?? "ll")
                            print(weather.main?.humidity ?? "loading")
                            
                            
                            print(weather.weather?.description ?? "loading")
                            
                            //var WW = [weather.weather?.description]
                            print("HEllooo\(weather.weather![0].description ?? "loading")")
                            
                            //----
                            self.city = weather.name ?? "loading..."
                            
                            self.description = weather.weather![0].description ?? "loading"
                            self.temp = Int(weather.main?.temp ?? 0)
                            self.t_max = Int(weather.main?.temp_max ?? 0)
                            self.t_min = Int(weather.main?.temp_min ?? 0)
                            self.t_feel = Int(weather.main?.feels_like ?? 0)
                            self.humidity = Int(weather.main?.humidity ?? 0)
                            self.cloudPer = weather.clouds?.percentage ?? 0
                            
                            //self.sunrise = weather.sys?.sunrise
                            //self.sunset = weather.sys?.sunset
                            
                            self.sunrise = self.utcToSystemTime(time: (weather.sys?.sunrise)!)
                            self.sunset = self.utcToSystemTime(time: (weather.sys?.sunset)!)
                            
                            self.iconData = weather.weather![0].icon ?? "loading"
                            self.weatherStatus = weather.weather![0].icon ?? "01d"
                            //self.weatherStatus.removeLast()
                            
                            //----
                            DispatchQueue.main.async {
                                //completion(weather)
                            }
                            
                        } catch {
                            print("JSON Decoding Error: \(error.localizedDescription)")
                        }
                    }
                }
            }.resume()
    }
    
    
 }







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
