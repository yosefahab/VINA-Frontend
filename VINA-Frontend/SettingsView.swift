//
//  SettingsView.swift
//  VINA
//
//  Created by Youssef Ahab on 08/07/2022.
//

import SwiftUI


struct SettingsView: View {
    @AppStorage("narrateBN") var narrateBN: Bool = true
    @AppStorage("tint") var tint: String = Theme.clear.name
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Background Tint")
                Menu(tint.capitalized) {
                    ForEach(Theme.allCases) { theme in
                        Button(theme.name, action: { self.tint = theme.name })
                    }
                }
            }
            Spacer()
            Toggle("Narrate Breaking News", isOn: $narrateBN)
        }
        .padding(20)
        .frame(width: 350, height: 100)
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
