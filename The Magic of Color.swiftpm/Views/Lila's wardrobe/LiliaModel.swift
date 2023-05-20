//
//  SwiftUIView.swift
//  
//
//  Created by Supachod Trakansirorut on 22/4/2565 BE.
//

import SwiftUI

// Reusable Lila Model with options to change her accessories color
struct LilaModel: View {
    @Binding var bowColor: Color
    @Binding var dressColor: Color
    @Binding var shoesColor: Color

    var body: some View {
        ZStack {
            Image("Body")
                .resizable()
                .scaledToFit()
            Group {
                Image("Bow filled")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(bowColor)
                    .scaledToFit()
                Image("Bow trans")
                    .resizable()
                    .scaledToFit()
            }
            Group {
                Image("Dress filled")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(dressColor)
                    .scaledToFit()
                Image("Dress trans")
                    .resizable()
                    .scaledToFit()
            }
            Group {
                Image("Shoe filled")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(shoesColor)
                    .scaledToFit()
                Image("Shoe trans")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
