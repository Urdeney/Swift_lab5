//
//  ElementDetailView.swift
//  lab5
//
//  Created by UrdenVM on 25.02.2026.
//
import SwiftUI


struct ElementDetailView: View {
    var element: ElementData
    
    var body: some View {
        ScrollView() {
            Text(element.name)
                .font(.title)
            
            Divider()
            VStack {
                Text("Spell's index: \(element.index)").frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 15)
                Text("Spell's name: \(element.name)").frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 15)
                Text("Spell's level: \(element.level)").multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 15)
                Text("API Url for spell: https://www.dnd5eapi.co/\(element.url)").multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading)
            }.padding([.horizontal], 10)
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

