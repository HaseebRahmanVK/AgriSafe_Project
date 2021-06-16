// import 'dart:collection';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import 'package:http/http.dart' as http;
import '../models/animal.dart';
import '../models/user.dart';
import '../models/auth.dart';

class ConnectedProductsModel extends Model {
  List<Animal> _animals = [];
  // final List<Animal> fetchedAnimalList = [];
  String _selAnimalId;

  User _authenticatedUser;
  bool _isLoading = false;
}

class IntrusionHistory extends ConnectedProductsModel {
  // var storage = firebase.storage();

  // final List<Animal> fetchedAnimalList = [];
  List<Animal> get allAnimals {
    return List.from(_animals);
  }

  int get selectedAnimalIndex {
    return _animals.indexWhere((Animal animal) {
      return animal.animalId == _selAnimalId;
    });
  }

  String get selectedAnimalId {
    return _selAnimalId;
  }

  Animal get selectedAnimal {
    if (selectedAnimalId == null) {
      return null;
    }
    return _animals.firstWhere((Animal animal) {
      return animal.animalId == _selAnimalId;
    });
  }

  static get firebase => null;

  Future<Null> fetchAnimals() async {
    _isLoading = true;
    _animals = [];
    // final fetchedAnimalList = [];
    notifyListeners();
    final response = await http.get(Uri.parse(
        'https://agrisafe-1aecb-default-rtdb.firebaseio.com/users/${_authenticatedUser.id}/history.json?auth=${_authenticatedUser.token}'));
    final List<Animal> fetchedAnimalList = [];
    final Map<String, dynamic> animalListData = json.decode(response.body);

    print(_authenticatedUser.id);
    if (animalListData == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    print(animalListData);

    animalListData.forEach((String animalId, dynamic animalData) {
      final Animal animal = Animal(
        Time: animalData['Time'],
        image: animalData['image'],
        // image: downloadUrl,
        label: animalData['label'],

        // userEmail: animalData['userEmail'],
        animalId: animalData['id'],
      );

      fetchedAnimalList.add(animal);
    });
    _animals = fetchedAnimalList;
    print("fetched Animal List");
    print(fetchedAnimalList);
    _isLoading = false;
    notifyListeners();

    // });
  }

  Future<Null> deleteAnimal() {
    _isLoading = true;
    final deleteAnimalId = selectedAnimal.animalId;

    _animals.removeAt(selectedAnimalIndex);
    _selAnimalId = null;
    notifyListeners();
    return http
        .delete(Uri.parse(
            'https://agrisafe-1aecb-default-rtdb.firebaseio.com/users/${_authenticatedUser.id}/history/${deleteAnimalId}.json?auth=${_authenticatedUser.token}'))
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectAnimal(String AnimalId) {
    _selAnimalId = AnimalId;
    notifyListeners();
  }
}



class UserModel extends ConnectedProductsModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCUuHyHhD3hEfCVczK8--xJDdXJ6pG6NyI'),
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCUuHyHhD3hEfCVczK8--xJDdXJ6pG6NyI'),
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went Wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);

      setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Email already Exists';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This Email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The Password is Invalid';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeout(tokenLifeSpan);
      notifyListeners();
    }
  }

  void logout() async {
    print('Logout');
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }

  // print(json.decode(response.body)); //token
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
