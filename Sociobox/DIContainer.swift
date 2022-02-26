import Foundation

protocol DIContainerProtocol {
  func register<Component>(type: Component.Type, component: Any)
  func resolve<Component>(type: Component.Type) -> Component?
}


final class DIContainer: DIContainerProtocol {
  
  static let shared = DIContainer()
  // Since you mark the initializer as private, you essentially ensure your container is a singleton. This prevents any unintentional use of multiple instances and unexpected behavior, like missing some dependencies.
  private init() {}
  
  var components: [String: Any] = [:]
  
  func register<Component>(type: Component.Type, component: Any) {
    components["\(type)"] = component
  }
  
  func resolve<Component>(type: Component.Type) -> Component? {
    return components["\(type)"] as? Component
  }

}
