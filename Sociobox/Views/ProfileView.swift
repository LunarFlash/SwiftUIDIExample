import SwiftUI

struct ProfileView: View {

  private let user: User
  
  private let provider: ProfileContentProviderProtocol
  
  init(provider: ProfileContentProviderProtocol = DIContainer.shared.resolve(type: ProfileContentProviderProtocol.self)!, user: User = DIContainer.shared.resolve(type: User.self)!) {
    self.provider = provider
    self.user = user
  }

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        VStack {
          ProfileHeaderView(
            user: user,
            canSendMessage: provider.canSendMessage,
            canStartVideoChat: provider.canStartVideoChat
          )
          provider.friendsView
          provider.photosView
          provider.feedView
        }
      }
      .navigationTitle("Profile")
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    let user: User = Mock.user()
    let provider = ProfileContentProvider(privacyLevel: .friend, user: user)
    ProfileView(provider: provider, user: user)
  }
}

// MARK: - Profile views

struct PhotosView: View {
  private let photos: [String]

  init(photos: [String]) {
    self.photos = photos
  }

  var body: some View {
    VStack {
      Text("Recent photos").font(.title2)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(photos, id: \.self) { url in
            ImageView(withURL: url).frame(width: 200, height: 200).clipped()
          }
        }
      }
    }
  }
}

struct UsersView: View {
  private let users: [User]
  private let title: String

  init(title: String, users: [User]) {
    self.users = users
    self.title = title
  }

  var body: some View {
    VStack {
      Text(title).font(.title2)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(users, id: \.self) { user in
            VStack {
              ImageView(withURL: user.imageURL).frame(width: 80, height: 80).clipped()
              Text(user.name)
            }
          }
        }
      }
    }
  }
}

struct ProfileHeaderView: View {
  private let user: User
  private let canSendMessage: Bool
  private let canStartVideoChat: Bool

  init(user: User, canSendMessage: Bool, canStartVideoChat: Bool) {
    self.user = user
    self.canSendMessage = canSendMessage
    self.canStartVideoChat = canStartVideoChat
  }

  var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 16) {
        Spacer()
        if canStartVideoChat {
          Button(action: {}) {
            Image(systemName: "video")
          }
        }
        if canSendMessage {
          Button(action: {}) {
            Image(systemName: "message")
          }
        }
      }.padding(.trailing)
      ImageView(withURL: user.imageURL).clipShape(Circle()).frame(width: 100, height: 100).clipped()
      Text(user.name).font(.largeTitle)
      HStack {
        Image(systemName: "location")
        Text(user.area).font(.subheadline)
      }.padding(2)
      Text(user.bio).font(.body).padding()
    }
  }
}

// MARK: - History feed views

struct HistoryFeedView: View {
  private let posts: [Post]

  init(posts: [Post]) {
    self.posts = posts
  }

  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack {
        Text("Recent posts").font(.title2)
        ForEach(posts, id: \.self) { post in
          PostView(post: post)
        }
      }
    }
  }
}

struct PostView: View {
  private let post: Post

  init(post: Post) {
    self.post = post
  }

  var body: some View {
    VStack {
      ImageView(withURL: post.pictureURL).frame(height: 200).clipped()
      HStack {
        Text(post.message)
        Spacer()
        HStack {
          Image(systemName: "hand.thumbsup")
          Text(String(post.likesCount))
        }
        HStack {
          Image(systemName: "bubble.right")
          Text(String(post.commentsCount))
        }
      }.padding()
    }
  }
}

struct RestrictedAccessView: View {
  var body: some View {
    VStack {
      Image(systemName: "eye.slash").padding()
      Text("The access to the full profile info is restricted")
    }
  }
}
