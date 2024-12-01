import 'dart:developer';
import 'package:bike_ride/back%20end/services/users_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:bike_ride/back%20end/models/user.dart';

mixin LoginFunctionality {

  Future<Map<String, dynamic>> createAccount(
      {required AccountType accountType,
      String email = '',
      String password = ''}) async {
    // login to firebase auth
    Map<String, dynamic> userAndError = accountType == AccountType.ANONYMOUS
        ? await anonymousLogin()
        : await createEmailAndPasswordUser(email: email, password: password);

    // if there was an error at firebase auth
    if (userAndError['error'] != LoginErrors.none) {
      return userAndError;
    }

    // create user in our cloud database
    User? user = await saveUser(userAndError['user']);

    // make sure the user was created, if not revert the firebase auth login
    if (user == null) {
      _deleteAuthUser();
      userAndError['error'] = LoginErrors.inComplete;
    }

    return userAndError;
  }

  void _deleteAuthUser() {
    try {
      firebase.FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      log('cant delete user. Error: $e');
    }
  }

  Future<Map<String, dynamic>> anonymousLogin() async {
    /// creates FirebaseAuth.instance.signInAnonymously()
    /// returns a map of {user: firebase.User?, error: LoginErrors}

    Map<String, dynamic> returnMap = {
      'user': null,
      'error': LoginErrors.none,
    };

    try {
      final userCredential =
      await firebase.FirebaseAuth.instance.signInAnonymously();

      returnMap['user'] = userCredential.user!;
    } on firebase.FirebaseAuthException catch (e) {
      returnMap['error'] = _getErrorType(_standardizeErrorCode(e.code));
    }

    return returnMap;
  }


  Future<Map<String, dynamic>> createEmailAndPasswordUser(
      {required String email, required String password}) async {
    /// creates FirebaseAuth.instance.createUserWithEmailAndPassword
    /// returns a map of {user: firebase.User?, error: LoginErrors}

    Map<String, dynamic> returnMap = {
      'user': null,
      'error': LoginErrors.none,
    };

    try {
      final userCredential = await firebase.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      returnMap['user'] = userCredential.user!;
    } on firebase.FirebaseAuthException catch (e) {
      returnMap['error'] = _getErrorType(_standardizeErrorCode(e.code));
    }

    return returnMap;
  }

  Future<Map<String, dynamic>> signInToEmailAndPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> returnMap = {
      'user': null,
      'error': LoginErrors.none,
    };

    try {
      final userCredential = await firebase.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

      returnMap['user'] = userCredential.user!;
    } on firebase.FirebaseAuthException catch (e) {
      returnMap['error'] = _getErrorType(_standardizeErrorCode(e.code));
    }

    return returnMap;
  }

  LoginErrors _getErrorType(String errorCode) {
    for (LoginErrors error in LoginErrors.values) {
      if (error.name == errorCode) {
        return error;
      }
    }

    return LoginErrors.unknown;
  }

  String _standardizeErrorCode(String errorCode) {
    // if errorCode is one word no operation is needed
    if (!errorCode.contains('-')) return errorCode;

    // split using '-'
    List<String> splitText = errorCode.split('-');

    // list of standardized text
    List<String> goodText = [splitText[0]];

    // upperCase first letter in each item except the first item
    for (String text in splitText.sublist(1)) {
      goodText.add(text[0].toUpperCase() + text.substring(1));
    }

    // join items
    return goodText.join();
  }

  Future<User?> saveUser(firebase.User userFire) async {
    // create new my_model.user
    User? newUser = User(
      userId: userFire.uid,
      name: '',
      phoneNumber: '',
      accountType:
          userFire.isAnonymous ? AccountType.ANONYMOUS : AccountType.PERMANENT,
      favouriteBike: [],
    );

    // save to firebase
    newUser = await UsersServices().createUser(newUser);

    return newUser;
  }

  Future<User?> fetchUser() async {
    // fetch from UsersServices
    List userList = await UsersServices().ofUId(getLoggedInUId());

    return userList.isEmpty ? null : userList[0];
  }

  String getLoggedInUId() {
    /// Gives you the uId of the logged in user
    ///
    return firebase.FirebaseAuth.instance.currentUser!.uid;
  }
}

enum LoginErrors {
  none,

  /// No error

  inComplete,

  /// login not complete, shall revert to home page

  unknown,

  /// unknown error

  emailAlreadyInUse,

  /// Thrown if there already exists an account with the given email address.

  invalidEmail,

  /// Thrown if the email address is not valid.

  operationNotAllowed,

  /// Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.

  weakPassword,

  /// Thrown if the password is not strong enough.

  tooManyRequests,

  /// Thrown if the user sent too many requests at the same time, for security
  /// the api will not allow too many attempts at the same time, user will have
  /// to wait for some time

  userTokenExpired,

  /// Thrown if the user is no longer authenticated since his refresh token has been expired

  networkRequestFailed,

  /// Thrown if there was a network request error, for example the user don't don't have internet connection

  userDisabled,

  /// Thrown if the user corresponding to the given email has been disabled.

  userNotFound,

  /// Thrown if there is no user corresponding to the given email.

  wrongPassword,

  /// Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.

  invalidCredential,

  /// Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set. depending on if you are using firebase emulator or not the code is different
}
