//
//  SwiftUIView.swift
//  
//
//  Created by Supachod Trakansirorut on 22/4/2565 BE.
//

import SwiftUI

struct QuizNoteView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var start: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Group {
                        Text(
                        """
                        Now that you’ve learn and experiment with how colors are being mixed together by hand (actually…. more like by finger). It’s time to test some knowledge!👨‍🎓

                        **Quick tip**
                        Every combination of colors will result in different color output, so it’s not possible for 2 or more questions to have the same answer! And don't panic, as you can always try again and again.

                        **Interesting fact**
                        *All the accent colors Apple uses for their devices, including the one used in this quiz (aka Color.red, Color.green, Color.blue, etc. in SwiftUI language) is actually not pure red, green, and blue!

                        For instance: Pure blue is (0, 0, 255), but 'Apple blue' is (0, 122, 255)🤯. Not only that, 'Apple Blue' you see can also change its own color to (10, 132, 255) when the device is in dark mode, which help improve readability! Not convince? Try playing this quiz in both dark and light mode and see if you can spot the difference🔍.

                        It really is fascinating how such small detail is being handled carefully by the designers team at Apple.*

                        """
                        )
                    }
                    .padding()
                }

                Button("Start") {
                    dismiss()
                }
                .font(.title3.bold())
                .buttonStyle(BorderedButtonStyle())
                .padding(40)

            }
            .navigationBarTitle("Mini Quick Quiz!")
        }
        .onDisappear {
            start = true
        }
    }
}
