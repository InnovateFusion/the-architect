import 'dart:async';
import 'dart:io';

import 'package:architect/features/architect/presentations/bloc/user/user_bloc.dart';
import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/widget/error.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:architect/features/architect/presentations/widget/post/post.dart';
import 'package:architect/features/architect/presentations/widget/tag.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../domains/entities/user.dart';
import '../bloc/post/post_bloc.dart';
import '../widget/custom_bottom_navigation.dart';
import '../widget/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static const String name = '/home';
}

class _HomePageState extends State<HomePage> {
  late PostBloc postBloc;
  late UserBloc userBloc;
  final _scrollController = ScrollController();
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

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    userBloc = sl<UserBloc>();
    userBloc.add(ViewUsersEvent());
    userBloc.stream.listen((event) {
      if (event is UserLoaded) {
        setState(() {
          user = event.user;
        });
      }
    });

    postBloc = sl<PostBloc>();

    postBloc.add(const AllPosts(tags: [], skip: 0));
  }

  final List<String> xTags = [
    "exterior",
    "facade",
    "outdoor",
    "landscape",
    "outdoor",
    "interior",
    "indoor",
    "interior",
    "decor",
    "lighting",
    "space planning",
    "furniture design",
  ];

  final Set<String> selectedTags = {};
  bool isSelected(String tag) => selectedTags.contains(tag);
  int length = 0;

  void selectTag(BuildContext context, String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
    if (selectedTags.isNotEmpty) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        context.read<PostBloc>().add(AllPosts(tags: selectedTags.toList()));
      });
    } else {
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        context.read<PostBloc>().add(const AllPosts(tags: [], skip: 0));
      });
    }
  }

  void searchPosts(BuildContext context, String search) {
    if (search.isNotEmpty) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        context.read<PostBloc>().add(AllPosts(search: search));
      });
    } else {
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        context.read<PostBloc>().add(const AllPosts(tags: [], skip: 0));
      });
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Search(onChanged: searchPosts),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setting(
                              user: user,
                            ),
                          ),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(user.image)),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  BlocListener<PostBloc, PostState>(
                    listener: (context, state) {},
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: xTags.map(
                          (e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Tag(
                                  isSelected: isSelected(e),
                                  text: e,
                                  onPressed: (e) => selectTag(context, e)),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state.status == PostStatusAll.loading) {
                        return const LoadingIndicator();
                      } else if (state.status == PostStatusAll.initial) {
                        return const LoadingIndicator();
                      } else if (state.status == PostStatusAll.success) {
                        if (state.posts.isEmpty) {
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: () {
                                setState(() {
                                  selectedTags.clear();
                                });
                                context
                                    .read<PostBloc>()
                                    .add(const AllPosts(tags: [], skip: 0));
                                return Future<void>.value();
                              },
                              color: Colors.black,
                              child: ListView(
                                children: const [
                                  ErrorDisplay(
                                      message: 'Something went wrong.. ')
                                ],
                              ),
                            ),
                          );
                        }

                        length = state.posts.length;
                        return displayPosts(state);
                      } else {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              setState(() {
                                selectedTags.clear();
                              });
                              context
                                  .read<PostBloc>()
                                  .add(const AllPosts(tags: [], skip: 0));
                              return Future<void>.value();
                            },
                            color: Colors.black,
                            child: ListView(
                              children: const [
                                ErrorDisplay(message: 'Something went wrong.. ')
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 40,
              right: 40,
              child: CustomBottomNavigation(user: user, currentNav: 0),
            ),
          ],
        ),
      ),
    );
  }

  Timer? _debounce;
  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      context.read<PostBloc>().add(AllPosts(skip: length));
    });
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Expanded displayPosts(PostState state) {
    return Expanded(
      child: RefreshIndicator(
        color: Colors.black,
        onRefresh: () {
          context.read<PostBloc>().add(const AllPosts(tags: [], skip: 0));
          return Future<void>.value();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              state.hasReachedMax ? state.posts.length : state.posts.length + 1,
          itemBuilder: (context, index) {
            if (index >= state.posts.length) {
              return const BottomLoader();
            } else {
              if (state.hasReachedMax && index == state.posts.length - 1) {
                return Column(
                  children: [
                    Post(
                      index: index,
                      user: user,
                      post: state.posts[index],
                      posts: state.posts,
                    ),
                    const SizedBox(height: 90),
                  ],
                );
              } else {
                return Post(
                  index: index,
                  user: user,
                  post: state.posts[index],
                  posts: state.posts,
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 90),
      child: SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.black : Colors.white,
            ),
          );
        },
      ),
    );
  }
}
