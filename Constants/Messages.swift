//
//  Messages.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 04/04/23.
//

import Foundation
import SwiftUI

class GlobalMessages: ObservableObject {
    static let shared = GlobalMessages()

    @Published var messages1 = [
        "Hello, nice to meet you!\nMy name is Ana and I’m a math teacher!",

        "Despite being a teacher, I was also a student at one time and, as such, I have always been fascinated by how simple mathematical concepts can be, or sometimes become very complex.",

        "And something that I’ve learned about these concepts is that they can also teach us lessons about our lives!",

        "Don’t believe me?\nLet me show you something.",

        "",
    ]
    @Published var messages2 = [
        "This is a pendulum.",

        "Not very hard to understand, is it?",

        "The variables that can affect it are it’s mass, the length of the rope and gravity!",

        "Now lets make things more interesting.",

        "",
    ]
    @Published var messages3 = [
        "This is a double pendulum, which means there’s a pendulum hanging from another pendulum.",

        "It becomes much harder to predict how it’s going to behave when there are 2 pendulums.",

        "Very small changes to the variables at the start can result in totally different results at the end.",

        "We call this behavior chaotic",

        "",
    ]
    @Published var messages4 = [
        "Notice how these pendulums have very little difference in their starting angles.",

        "Now start the simulation and see how their trajectories will behave!",

        "",
    ]
    @Published var messages5 = [
        "Did you see how a very small change can result in a very great impact?",

        "What if I told you that our actions impact the world in the very same way?",

        "Sometimes people feel discouraged to take actions as they imagine it would not make any difference!",

        "Every action we take, no matter how small, is capable of changing the world we live in!",
    ]
}
