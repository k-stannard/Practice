//
//  ContentView.swift
//  SwiftUI Charts
//
//  Created by Koty Stannard on 7/30/22.
//

import SwiftUI
import Charts

struct Pancakes: Identifiable {
    var id = UUID()
    var name: String
    var sales: Int
}

struct PancakeChart: View, Identifiable {
    let name: String
    let color: Color
    let id = UUID()
    
    let pancakes: [Pancakes] = [
        Pancakes(name: "american", sales: 23),
        Pancakes(name: "swedish", sales: 32),
        Pancakes(name: "german", sales: 46),
        Pancakes(name: "swiss", sales: 39),
        Pancakes(name: "spanish", sales: 65),
        Pancakes(name: "portuguese", sales: 54),
    ]
    
    var body: some View {
        VStack {
            Text(name)
            Chart {
                ForEach(pancakes) { pancake in
                    LineMark(x: .value("Pancake", pancake.name), y: .value("Sales", pancake.sales)).symbol(.circle).interpolationMethod(.catmullRom)
                }
            }.frame(height: 150)
        }.background(color).cornerRadius(8)
    }
}

struct NewView: View {
    let name: String

    var body: some View {
        Text("Selected lift: \(name)")
            .font(.largeTitle)
    }
}

struct ContentView: View {
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 140)),
    ]
    
    let height: CGFloat = 140
    
    let pancakeView = [
        PancakeChart(name: "Squat", color: Color(uiColor: .secondarySystemFill)),
        PancakeChart(name: "Bench", color: Color(uiColor: .secondarySystemFill)),
        PancakeChart(name: "Deadlift", color: Color(uiColor: .secondarySystemFill))
    ]
    
    var body: some View {
        NavigationView {

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(pancakeView) { view in
                        view
                    }
                }.background(NavigationLink("", destination: NewView(name: "squat")))
                .padding()
            }
            
            .navigationTitle("Progress")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
