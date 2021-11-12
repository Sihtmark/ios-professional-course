# NotificationCenter

![](images/2.png)

Sometimes you need to send messages far and wide in your app. And `NoficiationCenter` is a way to do that. In this section we are going to use `NotificationCenter` to help us with logout.

Let's start by adding a logout button to our `AccountSummaryViewController` screen, and see why sending that message back to our `AppDelegate` is harder than it looks.

## Adding a logout button

First let's add the logout button to our `AccountSummaryViewController`.

**AccountSummaryViewController**

```swift
lazy var logoutBarButtonItem: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    barButtonItem.tintColor = .label
    return barButtonItem
}()

extension AccountSummaryViewController {
    private func setup() {
        setupNavigationBar()

    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

// MARK: Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        
    }
}
```

If we run this logout button should now appear.

Discussion:

- Note how `label` is a color
- Explain `lazy var` - a different way of initializing controls

![](images/0.png)

If we click on the button, it won't do anything. That's because we haven't yet hooked it up to our protocol-delegate.

Now this leads to an interesting question. How do we send logout as a message back to the `AppDelegate`?

If we look at our view hierarchy we can see we've got a pretty long way to go if we wanted to use `protocol-delegate`.

![](images/1.png)

AppDelegate > MainViewController > AccountSummaryViewController

Better option here would be another communication pattern - `NotificationCenter`.


## Hooking up Notification Center

First let's add a new class in `Utils` to strongly type our notification names.

**NSNotificationName** 

```swift
extension Notification.Name {
     static let Logout = Notification.Name("Logout")
}
```

Then let's register for this event in our `AppDelegate`.

**AppDelegate**

```swift
loginViewController.delegate = self
onboardingViewController.delegate = self
    
registerForNotifications()

private func registerForNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
}

@objc func didLogout() {
```

Now that we are registered, we just need to fire the event when the user logs out.

**AccountSummaryViewController**

```swift
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
```

OK lets's test. 🎉

<iframe src="https://giphy.com/embed/MCZ39lz83o5lC" width="480" height="257" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/MCZ39lz83o5lC"></a></p>

Discuss Pros / Cons of NotificationCenter.

### Adding a launch screen

Add a launch screen image.

- Open `LaunchScreen.storyboard`.
- Add a `UIImageView` with image `banknote.fill`.
- Give width `240 pt`
- Give height `142 pt`
- Center


### Fix the label spacing

### Links that help

- [Apple NotificationCenter Documentation](https://developer.apple.com/documentation/foundation/notificationcenter)
