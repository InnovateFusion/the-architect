import 'package:architect/features/architect/presentations/page/bookmark.dart';
import 'package:architect/features/architect/presentations/page/chat.dart';
import 'package:architect/features/architect/presentations/page/drawing/drawing.dart';
import 'package:architect/features/architect/presentations/page/home.dart';
import 'package:architect/features/architect/presentations/page/team.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/user.dart';
import '../bloc/user/user_bloc.dart';

class FloatingNavigator extends StatefulWidget {
  const FloatingNavigator({super.key});

  @override
  State<FloatingNavigator> createState() => _FloatingNavigatorState();
}

class _FloatingNavigatorState extends State<FloatingNavigator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late UserBloc userBloc;
  late User user = const User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    image: '',
    followers: 0,
    following: 0,
    bio: '',
    country: '',
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    userBloc = sl<UserBloc>();
    userBloc.add(ViewUsersEvent());
    userBloc.stream.listen((event) {
      if (event is UserLoaded) {
        setState(() {
          user = event.user;
        });
      }
    });
  }

  bool _open = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildButton(int index, String tooltip, IconData icon) {
    final isSelected = _selectedIndex == index;
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      foregroundColor: Colors.white,
      backgroundColor: isSelected
          ? const Color(0xff22c55e)
          : Color.fromARGB(255, 142, 231, 175),
      heroTag: tooltip,
      onPressed: () {
        setState(() {
          _selectedIndex = index;
          _toggle();
        });
      },
      tooltip: tooltip,
      child: Icon(icon, color: isSelected ? Colors.white : Colors.white70),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_open) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _open = !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _selectedIndex == 0
              ? HomePage(user: user)
              : _selectedIndex == 1
                  ? Chat(user: user)
                  : _selectedIndex == 2
                      ? Draw(user: user)
                      : _selectedIndex == 3
                          ? BookMark(
                              user: user,
                            )
                          : _selectedIndex == 4
                              ? TeamPage(user: user)
                              : HomePage(user: user)),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_open)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildButton(0, 'Home', Icons.home),
                const SizedBox(height: 16),
                buildButton(1, 'Message', Icons.message),
                const SizedBox(height: 16),
                buildButton(2, 'Draw', Icons.draw),
                const SizedBox(height: 16),
                buildButton(3, 'Bookmark', Icons.bookmark),
                const SizedBox(height: 16),
                buildButton(4, 'Team', Icons.people),
                const SizedBox(height: 16),
              ],
            ),
          Padding(
            padding: _selectedIndex == 1
                ? const EdgeInsets.only(bottom: 70)
                : const EdgeInsets.only(bottom: 0),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 142, 231, 175),
              heroTag: 'toggle',
              onPressed: _toggle,
              tooltip: 'Toggle',
              child: _open
                  ? const Icon(Icons.close)
                  : _selectedIndex == 0
                      ? const Icon(Icons.home)
                      : _selectedIndex == 1
                          ? const Icon(Icons.message)
                          : _selectedIndex == 2
                              ? const Icon(Icons.draw)
                              : _selectedIndex == 3
                                  ? const Icon(Icons.bookmark)
                                  : _selectedIndex == 4
                                      ? const Icon(Icons.people)
                                      : const Icon(Icons.home),
            ),
          )
        ],
      ),
    );
  }
}
