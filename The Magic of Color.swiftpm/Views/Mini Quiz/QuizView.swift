import SwiftUI

struct QuizView: View {
    // Unlock Lila's wardrobe after finishing the quiz
    @Binding var unlock: Int

    // Contain 5 all questions
    @State var quiz: [QuestionSet]
    
    // Track time in second
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var time = 0
    
    // Return Color based on the color's name in String
    let swiftColor = ["Red":Color.red, "Green":Color.green, "Blue":Color.blue, "Yellow":Color.yellow, "Purple":Color.purple, "Orange":Color.orange, "Pink":Color.pink, "Brown":Color.brown, "Mint":Color.mint, "Teal":Color.teal]
    
    // Start game on appear, track round, and reveal answer when pass a certain time
    @State var start = false
    @State var round = 0
    @State var revealAnswer = false
    
    // Offset of the water coming out of the hose
    @State var showColor = false
    
    // Used for showing different status based on user interaction
    @State var incorrect = false
    @State var correct = false
    @State var finish = false

    //Show sheet when oven this view
    @State private var onAppearedGuide = false
    
    init(unlock: Binding<Int>) {
        // Initialize all questions as well as shuffle them
        let q1 = QuestionSet(leftColor: "Yellow", rightColor: "Blue", correctAnswer: "Green", choices: ["Pink", "Green", "Purple", "Orange"].shuffled())
        let q2 = QuestionSet(leftColor: "Red", rightColor: "Blue", correctAnswer: "Purple", choices: ["Brown", "Orange", "Green", "Purple"].shuffled())
        let q3 = QuestionSet(leftColor: "Yellow", rightColor: "Red", correctAnswer: "Orange", choices: ["Pink", "Blue", "Orange", "Mint"].shuffled())
        let q4 = QuestionSet(leftColor: "Red", rightColor: "Green", correctAnswer: "Brown", choices: ["Brown", "Purple", "Yellow", "Teal"].shuffled())
        let q5 = QuestionSet(leftColor: "Green", rightColor: "Blue", correctAnswer: "Teal", choices: ["Pink", "Teal", "Purple", "Red"].shuffled())
        quiz = [q1, q2, q3, q4, q5].shuffled()
        self._unlock = unlock
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(colors: [Color(red: 255/255, green: 171/255, blue: 129/255), Color(red: 240/255, green: 129/255, blue: 169/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack {
                    Spacer()

                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.thinMaterial)
                            .frame(width: 350, height: 120)

                        VStack {
                            Text("Can you guess what")
                                .font(.title.bold())
                            Group {
                                Text(quiz[round].leftColor)
                                    .foregroundColor(swiftColor[quiz[round].leftColor])
                                + Text(" + ")
                                + Text(quiz[round].rightColor)
                                    .foregroundColor(swiftColor[quiz[round].rightColor])
                                + Text(" = ???")
                            }
                        }
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    }
                    HStack(spacing: 0) {
                        ZStack {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(swiftColor[quiz[round].leftColor]!)
                                    .frame(width: showColor ? geo.size.width/2 : 0, height: 50)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)

                                Spacer()
                                    .frame(width: showColor ? 0 : geo.size.width)

                                Rectangle()
                                    .fill(swiftColor[quiz[round].rightColor]!)
                                    .frame(width: showColor ? geo.size.width/2 : 0, height: 50)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
                            }

                            HStack(spacing: 0) {
                                HoseHead()
                                Spacer()
                                Circle()
                                    .fill(revealAnswer ? swiftColor[quiz[round].correctAnswer]! : Color.white)
                                    .frame(width: geo.size.width/4, height: geo.size.width/4)
                                    .overlay(Circle().stroke(Color(UIColor.separator)))
                                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                                Spacer()
                                HoseHead()
                                    .rotationEffect(Angle(degrees: 180))
                            }
                        }
                    }
                    .padding(.vertical, 50)
                    HStack(spacing: 10) {
                        ForEach (quiz[round].choices, id: \.self) { choice in
                            Button {
                                if choice == quiz[round].correctAnswer {
                                    if round == 4 {
                                        withAnimation { finish = true }
                                    } else {
                                        withAnimation { correct = true }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            time = 0
                                            withAnimation(nil) {
                                                showColor = false
                                                revealAnswer = false
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                round += 1
                                                withAnimation { correct = false }
                                            }
                                        }
                                    }
                                } else {
                                    withAnimation { incorrect = true }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { withAnimation { incorrect = false } }
                                }
                            } label: {
                                Text(choice)
                                    .font(.title3.bold())
                                    .foregroundColor(Color(UIColor.label))
                                    .frame(width: 80, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(swiftColor[choice])
                        }
                    }
                    Spacer()
                }
                if incorrect {
                    Group {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.red)
                            .frame(width: geo.size.width - 50, height: geo.size.height - 50)
                            .padding()
                        VStack(spacing: 15) {
                            Text("Incorrect!")
                                .font(.largeTitle.bold())
                            Text("try again")
                                .font(.title)
                        }
                    }
                    .transition(AnyTransition.opacity.combined(with: .scale))
                }

                if correct {
                    Group {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.green)
                            .frame(width: geo.size.width - 50, height: geo.size.height - 50)
                            .padding()
                        VStack(spacing: 15) {
                            Text("Correct!")
                                .font(.largeTitle.bold())
                            Text("to the next question")
                                .font(.title)
                        }
                    }
                    .transition(AnyTransition.opacity.combined(with: .scale))
                }

                if finish {
                    Group {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.mint)
                            .frame(width: geo.size.width - 50, height: geo.size.height - 50)
                            .padding()
                        VStack(spacing: 15) {
                            Text("Correct!")
                                .font(.largeTitle.bold())
                            Text("You did it, you beat the game! 😎")
                                .font(.title)
                            Text("You have now unlocked Lila's wardrobe ")
                                .font(.title2)
                        }
                    }
                    .transition(AnyTransition.opacity.combined(with: .scale))
                }
            }
            .onDisappear {
                if finish == true {
                    withAnimation {
                        unlock = 3
                        UserDefaults.standard.set(self.unlock, forKey: "unlock")
                    }
                }
            }
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                if start == true {
                    time += 1
                    if time == 1 {
                        withAnimation(.easeInOut(duration: 6)) {
                            showColor = true
                        }
                    }
                    if time == 6 {
                        withAnimation(.linear(duration: 1)) {
                            revealAnswer = true
                        }
                    }
                }
            }
        }
        .onAppear {
            onAppearedGuide = true
        }
        .sheet(isPresented: $onAppearedGuide) {
            QuizNoteView(start: $start)
        }
    }
}

struct HoseHead: View {
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .frame(width: 70, height: 60)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .frame(width: 10, height: 70)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5)
        }
    }
}
