import 'dart:convert';
import 'package:listview_flutter/models/user.dart';
import 'package:listview_flutter/api.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var _users = List<User>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;

  _getUsers() {
    _isLoading = true;
    API.getUsers().then((response) {
      final List<User> usersList = [];

      final List<dynamic> usersData = json.decode(response.body);
      if (usersData == null){
        setState(() {
          _isLoading = false;
        });
      }

      for (var i = 0; i < usersData.length; i++) {
        final User user = User(
          id: usersData[i]['id'],
          name: usersData[i]['name'],
          email: usersData[i]['email']
        );
        usersList.add(user);
      }

      setState(() {
        _users = usersList;
        _isLoading = false;
      });
    }).catchError((Object error){
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<dynamic> _onRefresh() {
    return _getUsers();
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  Widget _buildUsersList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                child: ListTile(
                  title: Text(_users[index].name),
                  subtitle: Text(_users[index].email),
                ),
                padding: EdgeInsets.all(10.0),
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _users.length,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      )
      : _buildUsersList(),
    );
  }
}

class UserPage extends StatelessWidget {
  UserPage(this.data);
  final data;

  Widget build(BuildContext build) => Scaffold(
    appBar: AppBar(title: Text('User Profile'),),
    body: ListView.builder(
        itemBuilder: null),
  );
}