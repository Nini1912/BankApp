import XCTest

final class BankingFlowTests: BaseClass {

    private enum TestData {
        static let invalidEmail = "invalid-email"
        static let unregisteredEmail = "unregistered.user@example.com"
        static let password = "Qa7xK9mP2z"
        static let badlyFormatted = "badly formatted"
        static let malformed = "malformed"
        static let hasExpired = "has expired"

        static func uniqueEmail() -> String {
            "uitest.\(UUID().uuidString.prefix(8).lowercased())@example.com"
        }
    }

    private lazy var steps = EasyBankSteps(app: app)

    func testInvalidEmailFormatShowsError() {
        steps
            .openLogin()
            .logIn(email: TestData.invalidEmail, password: TestData.password)
            .assertLoginErrorContains(TestData.badlyFormatted)
    }

    func testInvalidCredentialsShowAuthenticationError() {
        steps
            .openLogin()
            .logIn(email: TestData.unregisteredEmail, password: TestData.password)
            .assertLoginErrorContains(TestData.malformed)
            .assertLoginErrorContains(TestData.hasExpired)
    }

    func testRegisterLogOutAndLogIn() {
        let email = TestData.uniqueEmail()

        steps
            .openRegistration()
            .register(email: email, password: TestData.password)
            .assertHomeDisplayed()
            .logOut()
            .assertLoginFormDisplayed()
            .logIn(email: email, password: TestData.password)
            .assertHomeDisplayed()
    }
}