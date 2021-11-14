# Animations


## Animating with constraints

- image 
- explain how it works

First define some variables to represent the edges of our constraints.

```swift
var password: String? {
    return loginView.passwordTextField.text
}

// animation
var leadingEdgeOnScreen: CGFloat = 16
var leadingEdgeOffScreen: CGFloat = -1000
```

Then modify the `titleLabel` constraints so we start with our titile off screen.

```swift
// Title
NSLayoutConstraint.activate([
    subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
    titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
])
    
titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
titleLeadingAnchor?.isActive = true
```

Then let's define the animation.

```swift
// MARK: - Animations
extension LoginViewController {
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
    }
}
```

Run the app now. And you should see the title appear offscreen.

Now comes the fun part. Animating the title in. To do this we need to hook into the `viewDidAppear` lifecycle of the view controller. We want the auto layout to have fully completed. Now we want to change the constraint and trigger the animation in.

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animate()
}
```

What makes this all work is this line here:

```swift
self.view.layoutIfNeeded()
```

This is a signal to layout the subview immediately if any values have changed. Which they have.

If we run this now, we should see the title label animate in.

Let's save our work.

```
> git add -p
> git commit -m "feat: Animate in login title label"
```

### Challenge - Animate in the subtitle

OK your turn. Following the step we just did for title, see if you can animate in the `subtitleLabel` just like we did for `titleLabel`.

- Define the constraint
- Update the layout to grab the leading edge
- Then set in the animation block.

Solution.

```swift
var subtitleLeadingAnchor: NSLayoutConstraint?

// Subtitle
NSLayoutConstraint.activate([
    loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
    subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
])
    
subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
subtitleLeadingAnchor?.isActive = true

let animation = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
    self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
    self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
    self.view.layoutIfNeeded()
}

```

Demo. Cool! That works nicely. But watch what we can do with animations. We can chain them together.

Let's create a second animator and do our subitle animation in there with a `0.5s` delay.

```swift
let animator2 = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
    self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
}
animator2.startAnimation(afterDelay: 0.25)
```

Save your work.

```
> git add -p
> git commit -m "feat: Add separate animation for subtitle label"
```


## 🪲 Debugging

If you ever want to see your animations in slow motion, select your simulator and go:

`Debug > Slow Animations`

## Playing with visibility and alpha

One common technique for making controls appear and fade is to play with this visibility and alpha.

For example we would blur these labels in by going initially setting their `alpha` to `0` and then setting it to `1` as part of the animation in:

```swift


```