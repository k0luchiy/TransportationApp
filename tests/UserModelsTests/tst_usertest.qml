import QtQuick 2.15
import QtTest 1.0

import UserModel 1.0

TestCase {
    name: "UserTest"

    User {
        id: user
    }

    function initTestCase() {
        user.firstName = "Anton"
        user.lastName = "Osipov"
        user.email = "antoshka.osipov.04@mail.ru"
    }

    function cleanupTestCase() {
    }

    function test_setters() {
        compare(user.firstName, "Anton", "First name");
        compare(user.lastName, "Osipov", "Last name");
        compare(user.email, "antoshka.osipov.04@mail.ru", "Email");
    }

    function test_exists() {
        verify(user.isExists(user.email), "Existing user")
        verify(!user.isExists("wrongcred@gmail.com"), "Wrong crederntials")
    }


}
