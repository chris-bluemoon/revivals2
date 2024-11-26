import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FB_Login extends StatelessWidget {
  final plugin = FacebookLogin(debug: true);

  FB_Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(plugin: plugin),
    );
  }
}

class MyHome extends StatefulWidget {
  final FacebookLogin plugin;

  const MyHome({Key? key, required this.plugin}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? _sdkVersion;
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;

  bool _isPending = false;

  @override
  void initState() {
    super.initState();

    _getFBSdkVersion();
    _updateFBLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null && _profile != null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login via Facebook example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
        child: Center(
          child: _isPending
              ? const CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
                    if (isLogin)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child:
                            _buildFBUserInfo(context, _profile!, _token!, _email),
                      ),
                    isLogin
                        ? OutlinedButton(
                            onPressed: _onPressedFBLogOutButton,
                            child: const Text('Log Out'),
                          )
                        : OutlinedButton(
                            onPressed: onPressedFBLogInButton,
                            child: const Text('Log In'),
                          ),
                    if (!isLogin && Platform.isAndroid)
                      OutlinedButton(
                        child: const Text('Express Log In'),
                        onPressed: () => _onPressedExpressLogInButton(context),
                      )
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFBUserInfo(BuildContext context, FacebookUserProfile profile,
      FacebookAccessToken accessToken, String? email) {
    final avatarUrl = _imageUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (avatarUrl != null)
          Center(
            child: Image.network(avatarUrl),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('User: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Text('AccessToken: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        if (email != null) Text('Email: $email'),
        Text('Limited Login: ${accessToken.isLimitedLogin ? 'YES' : 'NO'}'),
      ],
    );
  }

  Future<void> onPressedFBLogInButton() async {
    await widget.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateFBLoginInfo();
  }

  Future<void> _onPressedExpressLogInButton(BuildContext context) async {
    final res = await widget.plugin.expressLogin();
    if (res.status == FacebookLoginStatus.success) {
      await _updateFBLoginInfo();
    } else {
      await showDialog<Object>(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Can't make express log in. Try regular log in."),
        ),
      );
    }
  }

  Future<void> _onPressedFBLogOutButton() async {
    await widget.plugin.logOut();
    await _updateFBLoginInfo();
  }

  Future<void> _getFBSdkVersion() async {
    final sdkVersion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateFBLoginInfo() async {
    setState(() {
      _isPending = true;
    });
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
      _isPending = false;
    });
  }
}