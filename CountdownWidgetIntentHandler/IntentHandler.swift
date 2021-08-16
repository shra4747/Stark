//
//  IntentHandler.swift
//  CountdownWidgetIntentHandler
//
//  Created by Shravan Prasanth on 8/16/21.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    func provideCountdownOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<AvailableCountdowns>?, Error?) -> Void) {
        var countdowns: [WidgetModel] = []
        
        let encodedCountdownsData = UserDefaults(suiteName: "group.com.shravanprasanth.movietvwidgetgroup")!.object(forKey: "countdownsData") as? Data
        if let countdownsEncoded = encodedCountdownsData {
            let countdownsDecoded = try? JSONDecoder().decode([WidgetModel].self, from: countdownsEncoded)
            countdowns = countdownsDecoded ?? []
        }
        else {
            // No Models
            countdowns = []
        }
        
        let pickableCountdowns = countdowns.map { (countdown) -> AvailableCountdowns in
            let availableCountdown = AvailableCountdowns(identifier: countdown.title, display: countdown.title)
            availableCountdown.title = countdown.title
            availableCountdown.release_date = countdown.release_date
            availableCountdown.poster_path = countdown.poster_path
            return availableCountdown
        }
        
        let collection = INObjectCollection(items: pickableCountdowns)
        completion(collection, nil)
    }
}
