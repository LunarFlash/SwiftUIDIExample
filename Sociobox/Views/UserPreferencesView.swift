import SwiftUI
import Combine

struct UserPreferencesView<Store>: View where Store: PreferencesStoreProtocol {
  
  private var store: Store
  
  init(store: Store = DIContainer.shared.resolve(type: Store.self)!) {
    self.store = store
  }
  
  var body: some View {
    NavigationView {
      VStack {
        PreferenceView(title: .photos, value: .friend) { value in
          store.photosPreference = value
        }
        PreferenceView(title: .friends, value: .friend) { value in
          store.friendsListPreference = value
        }
        PreferenceView(title: .feed, value: .friend) { value in
          store.feedPreference = value
        }
        PreferenceView(title: .videoCall, value: .friend) { value in
          store.videoCallsPreference = value
        }
        PreferenceView(title: .message, value: .friend) { value in
          store.messagePreference = value
        }
        Spacer()
      }
    }.navigationBarTitle("Privacy preferences")
  }
}

struct PreferenceView: View {
  private let title: PrivacySetting
  private let value: PrivacyLevel
  private let onPreferenceUpdated: (PrivacyLevel) -> Void

  init(title: PrivacySetting, value: PrivacyLevel, onPreferenceUpdated: @escaping (PrivacyLevel) -> Void) {
    self.title = title
    self.value = value
    self.onPreferenceUpdated = onPreferenceUpdated
  }

  var body: some View {
    HStack {
      Text(title.rawValue).font(.body)
      Spacer()
      PreferenceMenu(title: value.title, onPreferenceUpdated: onPreferenceUpdated)
    }.padding()
  }
}

struct PreferenceMenu: View {
  @State var title: String
  private let onPreferenceUpdated: (PrivacyLevel) -> Void

  init(title: String, onPreferenceUpdated: @escaping (PrivacyLevel) -> Void) {
    _title = State<String>(initialValue: title)
    self.onPreferenceUpdated = onPreferenceUpdated
  }

  var body: some View {
    Menu(title) {
      Button(PrivacyLevel.closeFriend.title) {
        onPreferenceUpdated(PrivacyLevel.closeFriend)
        title = PrivacyLevel.closeFriend.title
      }
      Button(PrivacyLevel.friend.title) {
        onPreferenceUpdated(PrivacyLevel.friend)
        title = PrivacyLevel.friend.title
      }
      Button(PrivacyLevel.everyone.title) {
        onPreferenceUpdated(PrivacyLevel.everyone)
        title = PrivacyLevel.everyone.title
      }
    }
  }
}

struct UserPreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    UserPreferencesView<PreferencesStore>(store: PreferencesStore())
  }
}
