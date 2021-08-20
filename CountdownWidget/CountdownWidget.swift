//
//  CountdownWidget.swift
//  CountdownWidget
//
//  Created by Shravan Prasanth on 8/16/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), countdownModel: WidgetModel(title: "Tap and Hold to Edit!", release_date: "", poster_path: ""))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), countdownModel: WidgetModel(title: "Tap and Hold to Edit!", release_date: "", poster_path: ""))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        if let returnedSelectedCountdown = configuration.countdown {
            let selectedCountdown = WidgetModel(title: returnedSelectedCountdown.title!, release_date: returnedSelectedCountdown.release_date!, poster_path: returnedSelectedCountdown.poster_path!)
            
            let entries: [SimpleEntry] = [SimpleEntry(date: Date(), countdownModel: selectedCountdown)]
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            
            completion(timeline)
        }
        else {
            let selectedCountdown = WidgetModel(title: "Tap and Hold to Edit!", release_date: "", poster_path: "")
            
            let entries: [SimpleEntry] = [SimpleEntry(date: Date(), countdownModel: selectedCountdown)]
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let countdownModel: WidgetModel
}

struct CountdownWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            CountdownWidgetView(widgetModel: entry.countdownModel, widgetCase: .small)
        case .systemMedium:
            CountdownWidgetView(widgetModel: entry.countdownModel, widgetCase: .medium)
        case .systemLarge:
            CountdownWidgetView(widgetModel: entry.countdownModel, widgetCase: .large)
        @unknown default:
            fatalError()
        }
    }
}

@main
struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Countdown Widget")
        .description("Countdown the days until your favorite movies release!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CountdownWidget_Previews: PreviewProvider {
    static var previews: some View {
        CountdownWidgetEntryView(entry: SimpleEntry(date: Date(), countdownModel: WidgetModel(title: "Tap and Hold to Edit!", release_date: "", poster_path: "")))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
