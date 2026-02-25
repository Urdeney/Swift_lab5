//
//  ElementRowView.swift
//  lab5
//
//  Created by UrdenVM on 25.02.2026.
//
import SwiftUI

struct ElementRowView: View {
    var element: ElementData
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(element.name)
                .foregroundStyle(.black)
                .font(.title3)
            Spacer().frame(height: 15)
            HStack {
                Text("\(element.level) Level Spell")
            }
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
    }
}
