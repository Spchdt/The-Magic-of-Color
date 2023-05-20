//
//  SwiftUIView.swift
//  
//
//  Created by Supachod Trakansirorut on 22/4/2565 BE.
//

import SwiftUI

// This view is after the user have chosen a palette of their choice
struct ChooseColorView: View {
    // Tap play again will dismiss the view
    @Environment(\.dismiss) var dismiss

    // Passed from the previous view, this is to know which palette the user choose
    @State var selectedPalette: clothPalette

    // Passed from the previous view, used for dynamic layout
    let geo: GeometryProxy

    // Store colors for bow, dress, and shoes
    @State var colorCodes = [Color.white, Color.white, Color.white]

    // Track the current item user is choosing color for
    @State var selectedItem = 0

    // Toggle to true after user finish choosing colors for all items
    @State var finish = false

    // item index, used along side with selectedItem to show the item's name in String
    let itemName = [0:"bow", 1:"dress", 2:"shoes"]

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 254/255, green: 203/255, blue: 62/155), Color(red: 179/255, green: 223/255, blue: 139/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Spacer()

                Text(!finish ? "Choose a color for Lila's \(itemName[selectedItem]!)" : selectedPalette.endMessage)
                    .font(.title.bold())
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                HStack {
                    Spacer()
                    if !finish {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.thinMaterial)
                                .frame(width: 150, height: 500)

                            VStack {
                                ForEach(selectedPalette.colors, id: \.self) { color in
                                    Button {
                                        colorCodes[selectedItem] = color
                                    } label: {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .frame(width: 100, height: 50)
                                            .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color(UIColor.separator)))
                                    }
                                    .foregroundColor(color)
                                }

                                Button {
                                    guard selectedItem != 2 else {
                                        return withAnimation { finish = true }
                                    }
                                    selectedItem += 1
                                } label: {
                                    Text(selectedItem == 2 ? "Done" : "Next")
                                        .font(.title.bold())
                                }
                                .buttonStyle(BorderedButtonStyle())
                                .disabled(colorCodes[selectedItem] == Color.white)
                            }
                        }
                        Spacer()
                    }
                    LilaModel(bowColor: $colorCodes[0], dressColor: $colorCodes[1], shoesColor: $colorCodes[2])
                        .frame(height: geo.size.height/2)
                    Spacer()
                }

                Spacer()

                if finish {
                    Button("Play again") {
                        dismiss()
                    }
                    .font(.title.bold())
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color.blue)

                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}
