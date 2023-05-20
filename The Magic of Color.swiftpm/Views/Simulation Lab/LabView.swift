import SwiftUI

struct LabView: View {
    // Contain all 3 hoses
    @State var hoses = [hose(id: 0, color: Color.red, on: true), hose(id: 1, color: Color.green, on: true), hose(id: 2, color: Color.blue, on: true)]
    
    // Store color of the water
    @State var poolColor = Color(red: 0, green: 0, blue: 0)
    
    // Store the ankle of the wave
    @State private var waveOffset = Angle(degrees: 0)
    
    // Used for background gradient
    let lightBlue = Color(red: 109/255, green: 213/255, blue: 255/255)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [lightBlue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Wave(offset: waveOffset+Angle(degrees: 90))
                        .foregroundColor(poolColor)
                        .frame(width: geo.size.width + 40, height: geo.size.height/2-130)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, y: -5)
                }
                HStack {
                    Spacer()
                    LabNoteView(geo: geo)
                    Spacer()
                    HStack(spacing: (geo.size.width/2)/5) {
                        ForEach(hoses, id: \.self) { hose in
                            VStack(spacing: 0) {
                                Rectangle()
                                    .foregroundColor(Color.gray)
                                    .frame(width: 50, height: 120)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .frame(width: 90, height: 20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
                                ZStack(alignment: .bottom) {
                                    Rectangle()
                                        .frame(width: 60, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
                                    VStack {
                                        ColorPicker("Pick a color", selection: $hoses[hose.id].color, supportsOpacity: false)
                                            .labelsHidden()
                                            .frame(width: 30, height: 30)
                                        Toggle("", isOn: $hoses[hose.id].on)
                                            .labelsHidden()
                                            .padding(.bottom, 10)
                                    }
                                }
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .frame(width: 70, height: 10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
                                Rectangle()
                                    .fill(hose.on ? hose.color : Color.clear)
                                    .frame(width: 40, height: geo.size.height - 170)
                                    .overlay(
                                        Rectangle()
                                            .stroke(hose.on ? Color(UIColor.separator) : Color.clear)
                                    )
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
                            }
                        }
                    }
                    .offset(x: -20)

                    Spacer()
                }
                VStack {
                    Spacer()
                    Wave(offset: waveOffset)
                        .foregroundColor(poolColor)
                        .frame(width: geo.size.width + 40, height: geo.size.height/2-200)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, y: -5)
                        .offset(y: 20)
                }
            }
            .ignoresSafeArea()
        }
        .onChange(of: hoses) { _ in withAnimation { poolColor = calculateColorPool() } }
        .onAppear {
            poolColor = calculateColorPool()
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
    
    func calculateColorPool() -> Color {
        guard hoses[0].on || hoses[1].on || hoses[2].on else { return Color.white }
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var count: CGFloat = 0
        
        for hose in hoses {
            if hose.on {
                if let colors = UIColor(hose.color).cgColor.components {
                    red += colors[0]
                    green += colors[1]
                    blue += colors[2]
                    count += 1
                }
            }
        }
        red = (red)/count
        green = (green)/count
        blue = (blue)/count
        return Color(red: red, green: green, blue: blue)
    }
}

