import XCTest

final class EasyBankPage {
    enum ID {
        static let onboardingLogin = "onboarding.login"
        static let onboardingRegister = "onboarding.register"

        static let loginEmail = "login.email"
        static let loginPassword = "login.password"
        static let loginSubmit = "login.submit"
        static let loginError = "login.error"

        static let registrationEmail = "registration.email"
        static let registrationPassword = "registration.password"
        static let registrationRepeatPassword = "registration.repeatPassword"
        static let registrationSubmit = "registration.submit"

        static let homeSendMoney = "home.sendMoney"
        static let homeLogout = "home.logout"
    }

    enum Label {
        static let homeTab = "Home"
        static let logoutAlertTitle = "Logging Out"
        static let logoutConfirm = "Yes"
        static let passwordPlaceholder = "Password"
        static let repeatPasswordPlaceholder = "Repeat Password"
        static let keyboardReturn = "return"
    }

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var onboardingLoginButton: XCUIElement { app.buttons[ID.onboardingLogin] }
    var onboardingRegisterButton: XCUIElement { app.buttons[ID.onboardingRegister] }

    var loginEmailField: XCUIElement { app.textFields[ID.loginEmail] }
    var loginPasswordField: XCUIElement { app.secureTextFields[ID.loginPassword] }
    var loginSubmitButton: XCUIElement { app.buttons[ID.loginSubmit] }
    var loginErrorLabel: XCUIElement { app.staticTexts[ID.loginError] }

    var registrationEmailField: XCUIElement { app.textFields[ID.registrationEmail] }
    var registrationPasswordField: XCUIElement { app.secureTextFields[ID.registrationPassword] }
    var registrationRepeatPasswordField: XCUIElement { app.secureTextFields[ID.registrationRepeatPassword] }
    var registrationSubmitButton: XCUIElement { app.buttons[ID.registrationSubmit] }

    var registrationPasswordVisibilityToggle: XCUIElement { registrationPasswordField.buttons.firstMatch }
    var registrationRepeatPasswordVisibilityToggle: XCUIElement { registrationRepeatPasswordField.buttons.firstMatch }

    var registrationPasswordPlainField: XCUIElement {
        plainTextField(identifier: ID.registrationPassword, placeholder: Label.passwordPlaceholder)
    }
    var registrationRepeatPasswordPlainField: XCUIElement {
        plainTextField(identifier: ID.registrationRepeatPassword, placeholder: Label.repeatPasswordPlaceholder)
    }

    var homeTab: XCUIElement { app.tabBars.buttons[Label.homeTab] }
    var sendMoneyButton: XCUIElement { app.buttons[ID.homeSendMoney] }
    var logoutButton: XCUIElement { app.buttons[ID.homeLogout] }

    var logoutAlert: XCUIElement { app.alerts[Label.logoutAlertTitle] }
    var logoutConfirmButton: XCUIElement { logoutAlert.buttons[Label.logoutConfirm] }

    var keyboardReturnKey: XCUIElement {
        app.keyboards.buttons
            .matching(NSPredicate(format: "label ==[c] %@", Label.keyboardReturn))
            .firstMatch
    }

    private func plainTextField(identifier: String, placeholder: String) -> XCUIElement {
        app.textFields
            .matching(NSPredicate(format: "identifier == %@ OR placeholderValue == %@", identifier, placeholder))
            .firstMatch
    }
}