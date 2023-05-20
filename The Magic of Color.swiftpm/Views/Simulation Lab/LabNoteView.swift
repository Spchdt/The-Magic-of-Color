import SwiftUI

struct LabNoteView: View {
    let geo: GeometryProxy
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.thinMaterial)
                .frame(width: geo.size.width/2.3, height: geo.size.height)


            ScrollView {
                Group {
                    Text(
                    """
                    
                    **Welcome to the Simulation Lab**
                    """
                    )
                    .font(.title2)

                    Text(
                    """

                    **See the three hoses on the right?**
                    Each color of the hose is a primary color; red, green, and blue. Hence the name RGB.
                    """
                    )

                    Text (
                """

                **Knowing the basic of RGB**
                The RGB color model is one of the most well-known color system which are used in computers 💻, televisions 📺, and electronic devices 📱 for displaying colors.

                Each color you see on your display is a combination of the 3 primary colors, each primary color will have a value range from 0 to 255.

                    For Example:
                    - 🔴 Red will have (255, 0, 0)
                    - 🟢 Green - (0, 255, 0)
                    - 🔵 Blue - (0, 0, 255)

                See how each of our primary color has number '255' on different places?

                """
                    )

                    Text(
                """
                **Interesting fact**
                *Nowadays Apple devices support DCI-P3 color model, which has wider range of colors then RGB, allowing them to display more colors than before!*

                """
                    )

                    Text("**It's time to try something! ✌️**")
                        .font(.title3)

                    Text (
                 """

                 To demonstrate mixing color, I have chosen RGB color model for the simulation, since it is pretty straightforward in terms of how colors are mixed together.

                 Starting by switching off one of the hose’s toggle. Look at the change in the water! Because the water is a mixture of each hose's color, thus turning off a hose will result in a color change.

                 Now try choosing a different color for the hose. You can try as many combination as you like. Try adding Red and Blue together to get Purple, or mix Yellow with Blue to get Green. Also, turn back on all of the three hoses, and see how many variant of a single similar color (like blue, navy, teal, indigo) you can make out of!

                 **More fact**
                 *The output color for RGB color model is calculated by adding up all the r, g, and b values of the input colors, then divide it by the number of input colors.*

                    For example:
                    1. 🔴 Red (255, 0, 0) + 🔵 Blue (0, 0, 255) = (255, 0, 255)
                    2. Then divide (255, 0, 255) by 2 (since we are adding only 2 colors)
                    3. We’ll get (127.5, 0, 127.5), which is 🟣 Purple!
                 """
                    )

                    Spacer()
                        .frame(height: geo.size.height/2-130)
                }
                .padding()
            }
            .frame(width: geo.size.width/2.3, height: geo.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .offset(y: 50)
    }
}

