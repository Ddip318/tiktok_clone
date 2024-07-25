import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _dircetion = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _dircetion = Direction.right;
      });
    } else {
      setState(() {
        _dircetion = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_dircetion == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              duration: Duration(
                milliseconds: 300,
              ),
              firstChild: firstPage(),
              secondChild: secondPage(),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.size12,
            horizontal: Sizes.size12,
          ),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _showingPage == Page.first ? 1 : 0,
            child: CupertinoButton(
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              child: Text('Enter the app'),
            ),
          ),
        ),
      ),
    );
  }

  Column firstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v60,
        Text(
          "Watch cool videos!",
          style: TextStyle(
            fontSize: Sizes.size40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v16,
        Text(
          "Videos are personalized for you based on what you watch, like, and share",
          style: TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }

  Column secondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v60,
        FractionallySizedBox(
          widthFactor: 1,
          child: Text(
            "Follow the rules",
            style: TextStyle(
              fontSize: Sizes.size40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gaps.v16,
        Text(
          "Take care of one another! Phils",
          style: TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
