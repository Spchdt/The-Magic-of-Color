import SwiftUI

// View this app in fullscreen for the best experience!
// Images should already be included in this .swiftpm file, but I also create another folder for all the images in the zip file just in case.
struct ContentView: View {
    // Use for locking system
    @State private var unlock: Int
    
    init() {
        // Set UserDefault for unlock
        if UserDefaults.standard.integer(forKey: "unlock") == 0 {
            unlock = 1
        } else {
            unlock = UserDefaults.standard.integer(forKey: "unlock")
        }
    }
    var body: some View {
        GeometryReader { geo in

            NavigationView {
                ZStack {
                    LinearGradient(colors: [Color(red: 183/255, green: 236/255, blue: 254/255), Color(red: 244/255, green: 164/255, blue: 192/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()

                    HStack(spacing: geo.size.width/20) {
                        NavigationLink {
                            LabView()
                                .navigationBarTitleDisplayMode(.inline)
                                .onDisappear {
                                    if unlock == 1 {
                                        withAnimation(.spring()) {
                                            unlock = 2
                                            UserDefaults.standard.set(self.unlock, forKey: "unlock")
                                        }
                                    }
                                }
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color(red: 255/255, green: 115/255, blue: 99/255))
                                VStack {
                                    Image(systemName: "testtube.2")
                                    Text("Simulation Lab")
                                }
                                .foregroundColor(Color.white)
                                .font(.largeTitle.bold())
                            }
                            .frame(width: geo.size.width/4, height: geo.size.width/4)
                            .shadow(color: Color.black.opacity(0.2), radius: 5)
                        }

                        NavigationLink {
                            QuizView(unlock : $unlock)
                                .navigationBarTitleDisplayMode(.inline)

                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(unlock < 2 ? Color.gray : Color(red: 160/255, green: 215/255, blue: 110/255))
                                VStack {
                                    Image(systemName: unlock < 2 ? "lock" : "graduationcap")
                                    Text(unlock < 2 ? "Locked!" : "Mini Quiz")
                                }
                                .foregroundColor(Color.white)
                                .font(.largeTitle.bold())
                            }
                            .frame(width: geo.size.width/4, height: geo.size.width/4)
                            .shadow(color: Color.black.opacity(0.2), radius: 5)
                        }
                        .disabled(unlock < 2)

                        NavigationLink {
                            ClothingView()
                                .navigationBarTitleDisplayMode(.inline)

                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(unlock < 3 ? Color.gray : Color(red: 131/255, green: 177/255, blue: 255/255))
                                VStack {
                                    Image(systemName: unlock < 3 ? "lock" : "tshirt")
                                    Text(unlock < 3 ? "Locked!" : "Lila's wardrobe")
                                }
                                .foregroundColor(Color.white)
                                .font(.largeTitle.bold())
                            }
                            .frame(width: geo.size.width/4, height: geo.size.width/4)
                            .shadow(color: Color.black.opacity(0.2), radius: 5)
                        }
                        .disabled(unlock < 3)
                    }
                    .navigationTitle("The Magic of Color 🪄")
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

