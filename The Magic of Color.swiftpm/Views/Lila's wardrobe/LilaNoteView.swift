//
//  SwiftUIView.swift
//  
//
//  Created by Supachod Trakansirorut on 22/4/2565 BE.
//

import SwiftUI

struct LilaNoteView: View {
    let geo: GeometryProxy
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.thinMaterial)
                .frame(width: geo.size.width/2.5, height: geo.size.height - 60)


            ScrollView {
                Group {
                    Text(
                    """

                    **Lila's wardrobe**
                    """
                    )
                    .font(.title2)

                    Text(
                    """

                    Guess what... Lila is going to 🍎 WWDC22 tomorrow! Let's help her choose what style of colors she should wear on her special day.

                    **Experiment**
                    There are 4 color palettes she can choose from, each palette consist of six different colors. The palette is pre-made to make it unique from each other (and result in a different ending). How so? Well... let's try it out!

                    After you're satisfy with Lila's outfit, you can learn more about each color palette that you picked for her. (order from left to right)

                    """
                    )
                    Text("**Learn more**")
                        .font(.title3)
                    Text (
                    """

                    - **The "Earth tone"** 🌱: As the name suggested, earth tone consist of warm and natural-looking shades of colors like grass, dirt, and rock - giving a warm, safe, and reassuring feel.

                    - **The "90's"** 📻: Straight out of a comic book and pop art, 90's colors are playful and bright, just like how we children like with toys and cartoons.

                    - **The "Vintage"** 🚲: Although it is harder to define what is vintage, this 'milder than the 90's' color supposed to give out a sense of colors used in the 50s, like a color of an old photos, creamy-red car with no roof, or a blue-teal bicycle people ride back then.

                    - **The "Summer"** 🏖: Playing at a beach or not, this summer colors are based on the sea and the sand, with some warm colors to contrast it from the beach behind you to make you look good on your social media post.

                    You've finally reach the end of this app!🌟 I hope you'll learn some new things or at least have fun interacting with each game I have prepared.
                    """
                    )
                }
                .padding()
            }
            .frame(width: geo.size.width/2.5, height: geo.size.height - 60)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .padding()
    }
}
