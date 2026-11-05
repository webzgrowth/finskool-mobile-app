import Flutter
import UIKit

/// Keeps the app's content out of screenshots, screen recordings and the
/// app-switcher snapshot — it shows invoices, P&L figures and billing details.
///
/// **iOS has no API that forbids a screenshot.** The only way is the one banking
/// apps use: host the app's layer inside the secure container that
/// `UITextField.isSecureTextEntry` creates. The system never captures that
/// container, so a screenshot or recording shows it black while the app looks
/// normal on screen. Separately, the app-switcher snapshot is covered by a blur
/// while the app is inactive.
///
/// Set `blockCapture` to `false` to turn all of it off.
class SceneDelegate: FlutterSceneDelegate {
  // TEMPORARILY OFF so testers can screenshot and screen-record bugs to send
  // back. Set to `true` before an App Store release.
  private let blockCapture = false
  private var secureField: UITextField?
  private var cover: UIVisualEffectView?

  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    guard blockCapture, let window = window else { return }
    makeSecure(window)
  }

  private func makeSecure(_ window: UIWindow) {
    let field = UITextField()
    field.isSecureTextEntry = true
    field.isUserInteractionEnabled = false
    field.translatesAutoresizingMaskIntoConstraints = false
    window.addSubview(field)
    field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
    field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
    window.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.first?.addSublayer(window.layer)
    secureField = field
  }

  override func sceneWillResignActive(_ scene: UIScene) {
    super.sceneWillResignActive(scene)
    guard blockCapture, let window = window, cover == nil else { return }
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
    blur.frame = window.bounds
    blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    window.addSubview(blur)
    cover = blur
  }

  override func sceneDidBecomeActive(_ scene: UIScene) {
    super.sceneDidBecomeActive(scene)
    cover?.removeFromSuperview()
    cover = nil
  }
}
