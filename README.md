# Twitter Login In iOS App

1: First try to follow this steps and add their SDK in App.

https://github.com/twitter/twitter-kit-ios/wiki/Installation

2: After that Go to Appdelgate.swift file and add this:

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      TWTRTwitter.sharedInstance().start(withConsumerKey: "cZ0KGVebkYfHyeNvhoYmSI8Dx",consumerSecret: "VJCGJxEHpM5H7qQNAiq9YEyugIjLcAso8GDUtyqRvhYRP90t6r")
     
        return true
    }

Now add this method also in Appdelegate.swift file.

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url,options: options)
    }


3: Now go to ViewController.swift file and write the code in button action that will fetch user email & Name.                 
    
    func signIn() {
        loginButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let client = TWTRAPIClient()
                client.loadUser(withID: unwrappedSession.userID, completion: { (user, error) in
                    self.nameLabel.text = user?.name
                    self.userNameLabel.text = unwrappedSession.userName
                    if let imageUrl = user?.profileImageURL {
                        let url = URL(string: imageUrl)
                        let data = try? Data.init(contentsOf: url!)
                        self.profileImageView.image = UIImage(data: data!)
                    }
                    else {
                        print("Profile Image not present")
                    }
                })
            }
            else {
                print("Login Error")
            }
        }
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
  
4: Now you have done all the required things for fetching the user credential in App

5: Now last important things that open the twitter developer site and select your app (where you have registered your iOS app)

**Issue**: 
Faced Issue here. I got problem in call back url. Entered wrong call back url. 
Followed following steps then solved that issue

1.1: Now you have  to call back URL for App.

2.1: To get the call back URL
a: open info.plist file and copy URL schemes.

copy this ” twitterkit-js5zHyDKTz2RTthfgV5xl9icA”
Note: ” twitterkit- Your Consumer Key”
and Now open your twitter developer account & select your app.

3.1: edit the App account.

4.1: go to callback URLs section and paste it.
like that.

5.1:Now save this.

6: Now you are able to fetch the user data without any issue.
 


