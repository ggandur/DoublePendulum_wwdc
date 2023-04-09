import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    @Published var viewController: Int = 0
}

@main
struct MyApp: App {
    @StateObject var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            switch appSettings.viewController {
            case 0:
                ScientistView().environmentObject(appSettings)
            case 1:
                SinglePendulumView().environmentObject(appSettings)
            case 2:
                DoublePendulumDemonstrationView().environmentObject(appSettings)
            case 3:
                DoublePendulumView().environmentObject(appSettings)
            case 4:
                ResultsView().environmentObject(appSettings)
            case 5:
                VotingView().environmentObject(appSettings)
            case 6:
                PlanetView().environmentObject(appSettings)
            default:
                ScientistView().environmentObject(appSettings)
            }
        }
    }
}
