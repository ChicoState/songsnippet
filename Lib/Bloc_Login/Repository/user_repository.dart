import 'dart:async';
import 'package:meta/meta.dart';
import '../Login/API/Requests/get_user_object.dart';
import '../Dao/user_dao.dart';
import '../Login/API/Response/user_object.dart';
import '../Model/api_model.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    required String username,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(
        username: username,
        password: password
    );
    Token token = (await getToken(userLogin));
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken({
    required User user
  }) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future <void> deleteToken({
    required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }

  Future <Token> getCachedToken() async {
    Token? token = await userDao.getUserToken(0);
    if (token != null) {
      return token;
    }
    throw "Not logged in";
  }

  Future <void> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    UserDetails userDetails = UserDetails(
        username: userName,
        email: email,
        password: password
    );

    UserSignup userSignup = UserSignup(
      user: userDetails,
    );

    UserLogin registeredUser = await registerUser(userSignup);
    print("___________________");
    Token registeredUserToken = await getToken(registeredUser);


    User user = User(
      id: 0,
      username: userName,
      token: registeredUserToken.token,
    );
    await userDao.createUser(user);
  }
}