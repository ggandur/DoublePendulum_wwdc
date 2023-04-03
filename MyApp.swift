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
                DoublePendulumDemonstrationView()
            case 2:
                DoublePendulumView()
            default:
                ScientistView().environmentObject(appSettings)
            }
        }
    }
}
