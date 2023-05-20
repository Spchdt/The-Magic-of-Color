import SwiftUI

//Struct for each Question in Mini Quiz
struct QuestionSet: Hashable {
    let leftColor: String
    let rightColor: String
    let correctAnswer: String
    let choices: [String]
}
