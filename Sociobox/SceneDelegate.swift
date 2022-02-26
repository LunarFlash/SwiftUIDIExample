import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let container = DIContainer.shared
    container.register(type: PrivacyLevel.self, component: PrivacyLevel.friend)
    container.register(type: User.self, component: Mock.user())
    container.register(type: ProfileContentProviderProtocol.self, component: ProfileContentProvider())
    let profileView = ProfileView(provider: DIContainer.shared.resolve(type: ProfileContentProviderProtocol.self)!, user: DIContainer.shared.resolve(type: User.self)!)
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: profileView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
