import SwiftUI

struct ClothingView: View {
    // Contain all 4 palettes for Lila
    private let allPalettes: [clothPalette]
    
    // Randomly change Lila's bow, dress, and shoes every second
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let allColors: [Color]

    @State private var bowColor: Color
    @State private var dressColor: Color
    @State private var shoesColor: Color
    
    init() {
        // Handpicked colors for each palette
        let earthToneColors = [Color(red: 204/255, green: 172/255, blue: 151/255), Color(red: 172/255, green: 127/255, blue: 70/255), Color(red: 133/255, green: 88/255, blue: 57/255), Color(red: 125/255, green: 116/255, blue: 99/255), Color(red: 108/255, green: 129/255, blue: 124/255), Color(red: 76/255, green: 100/255, blue: 112/255)]
        let ninetiesColors = [Color(red: 133/255, green: 217/255, blue: 1/255), Color(red: 244/255, green: 207/255, blue: 13/255), Color(red: 42/255, green: 50/255, blue: 109/255), Color(red: 78/255, green: 159/255, blue: 188/255), Color(red: 201/255, green: 71/255, blue: 22/255), Color(red: 179/255, green: 52/255, blue: 108/255)]
        let vintageColors = [Color(red: 198/255, green: 57/255, blue: 53/255), Color(red: 208/255, green: 83/255, blue: 103/255), Color(red: 222/255, green: 144/255, blue: 127/255), Color(red: 247/255, green: 211/255, blue: 166/255), Color(red: 253/255, green: 209/255, blue: 113/255), Color(red: 98/255, green: 182/255, blue: 208/255)]
        let summerColors = [Color(red: 15/255, green: 55/255, blue: 109/255), Color(red: 67/255, green: 135/255, blue: 228/255), Color(red: 242/255, green: 145/255, blue: 8/255), Color(red: 68/255, green: 182/255, blue: 149/255), Color(red: 254/255, green: 231/255, blue: 178/255), Color(red: 226/255, green: 114/255, blue: 105/255)]
        
        let p1 = clothPalette(colors: earthToneColors, description: "Natural tone", endMessage: "I like this natural earthy tone, It gives me 'save the planet' vibe, just like what Apple is aiming for! ♻️")
        let p2 = clothPalette(colors: ninetiesColors, description: "kinda bright", endMessage: "Very bright and poppy 🌈. This palette reminded me of Apple's rainbow logo back in the early days")
        let p3 = clothPalette(colors: vintageColors, description: "Mild colors", endMessage: "Looks classy. I think my watch's 'golden brown leather link' band ⌚️ would go well with this dress")
        let p4 = clothPalette(colors: summerColors, description: "Surfing vibe", endMessage: "Great! Looks like I'm ready to visit beaches in Monterey... oh wait that was last year stuff. Wonder where we are heading to this year... 🤔")
        allPalettes = [p1, p2, p3, p4]
        allColors = earthToneColors + ninetiesColors + vintageColors + summerColors
        bowColor = allColors.randomElement()!
        dressColor = allColors.randomElement()!
        shoesColor = allColors.randomElement()!
    }
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(colors: [Color(red: 159/255, green: 230/255, blue: 253/255), Color(red: 255/255, green: 230/255, blue: 197/255), Color(red: 245/255, green: 174/255, blue: 199/255)], startPoint: .topTrailing, endPoint: .bottomLeading)

                HStack {
                    LilaNoteView(geo: geo)
                    VStack {
                        Text("What style should Lila wear to WWDC22?")
                            .font(.title.bold())
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            .padding([.top, .leading, .trailing])
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach (allPalettes, id:\.self) { palette in
                                    NavigationLink(destination: ChooseColorView(selectedPalette: palette, geo: geo)) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                .foregroundColor(Color.white)
                                                .frame(width: 150, height: 150)
                                            VStack {
                                                HStack(spacing:0) {
                                                    ForEach(palette.colors, id: \.self) { color in
                                                        Rectangle()
                                                            .foregroundColor(color)
                                                            .frame(width: 130/6, height: 60)
                                                    }
                                                }
                                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                Text(palette.description)
                                                    .foregroundColor(Color.black)
                                                    .font(.headline.bold())
                                                    .padding(5)
                                                    .background(.ultraThinMaterial)
                                                    .clipShape(
                                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                    )
                                                    .padding(5)
                                            }
                                        }
                                        .shadow(color: Color.black.opacity(0.2), radius: 5)
                                    }
                                }
                                .padding()
                            }
                        }
                        .background(.ultraThinMaterial)
                        .clipShape( RoundedRectangle(cornerRadius: 10, style: .continuous) )
                        .shadow(color: Color.black.opacity(0.2), radius: 5)
                        .padding()
                        
                        LilaModel(bowColor: $bowColor, dressColor: $dressColor, shoesColor: $shoesColor)
                            .frame(height: geo.size.height/2.5)
                            .onReceive(timer) { _ in
                                bowColor = allColors.randomElement()!
                                dressColor = allColors.randomElement()!
                                shoesColor = allColors.randomElement()!
                            }
                    }
                }
            }
            .ignoresSafeArea()

        }
        .navigationViewStyle(.stack)
    }
}
