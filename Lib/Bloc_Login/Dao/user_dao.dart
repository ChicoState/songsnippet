import '../Model/api_model.dart';
import '../Database/user_database.dart';
import '../Login/API/Response/user_object.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    this.deleteUser(user.id);
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db
          .query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }


  Future<Token?> getUserToken(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db
          .query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.isNotEmpty) {
        return Token(token: "TOKEN "+users[0]['token']);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}