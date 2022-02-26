import Foundation
import SwiftUI

protocol ProfileContentProviderProtocol {
  var privacyLevel: PrivacyLevel { get }
  var canSendMessage: Bool { get }
  var canStartVideoChat: Bool { get }
  var photosView: AnyView { get }
  var feedView: AnyView { get }
  var friendsView: AnyView { get }
}

final class ProfileContentProvider: ProfileContentProviderProtocol {
  
  let privacyLevel: PrivacyLevel
  private let user: User
  
  init(privacyLevel: PrivacyLevel = DIContainer.shared.resolve(type: PrivacyLevel.self)!, user: User = DIContainer.shared.resolve(type: User.self)!) {
    self.privacyLevel = privacyLevel
    self.user = user
  }
  
  var canSendMessage: Bool {
    privacyLevel > .everyone
  }
  
  var canStartVideoChat: Bool {
    privacyLevel > .everyone
  }
  
  var photosView: AnyView {
    privacyLevel > .everyone ?
    AnyView(PhotosView(photos: user.photos)) :
    AnyView(EmptyView())
  }
  
  var feedView: AnyView {
    privacyLevel > .everyone ?
    AnyView(HistoryFeedView(posts: user.historyFeed)) :
    AnyView(RestrictedAccessView())
  }
  
  var friendsView: AnyView {
    privacyLevel > .everyone ?
    AnyView(UsersView(title: "Friends", users: user.friends)) :
    AnyView(EmptyView())
  }
  
}
