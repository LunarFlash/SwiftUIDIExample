import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let user: User = Mock.user()
    let provider = ProfileContentProvider(privacyLevel: .everyone, user: user)
    let profileView = ProfileView(provider: provider, user: user)
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: profileView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
