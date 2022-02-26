import Foundation

protocol DIContainerProtocol {
  func register<Component>(type: Component.Type, component: Any)
  func resolve<Component>(type: Component.Type) -> Component?
}


final class DIContainer: DIContainerProtocol {
  
  static let shared = DIContainer()
  
  func register<Component>(type: Component.Type, component: Any) {
    
  }
  
  func resolve<Component>(type: Component.Type) -> Component? {
    
  }
  

  
    
  
}
