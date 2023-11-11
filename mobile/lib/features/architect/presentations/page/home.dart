import 'dart:async';
import 'dart:io';

import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/page/skeleton/home.dart';
import 'package:architect/features/architect/presentations/widget/error.dart';
import 'package:architect/features/architect/presentations/widget/post/post.dart';
import 'package:architect/features/architect/presentations/widget/tag.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../domains/entities/user.dart';
import '../bloc/post/post_bloc.dart';
import '../widget/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  _HomePageState createState() => _HomePageState();

  static const String name = '/home';
}

class _HomePageState extends State<HomePage> {
  late PostBloc postBloc;
  final _scrollController = ScrollController();

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    postBloc = sl<PostBloc>();

    postBloc.add(const AllPosts(tags: [], skip: 0));
  }

  final List<String> xTags = [
    "exterior",
    "interior",
    "facade",
    "outdoor",
    "indoor",
    "decor",
    "lighting",
    "landscape",
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
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatusAll.loading) {
            return const HomeShimmer();
          } else if (state.status == PostStatusAll.initial) {
            return const HomeShimmer();
          } else if (state.status == PostStatusAll.success) {
            if (state.posts.isEmpty) {
              return Scaffold(
                backgroundColor: const Color.fromARGB(255, 236, 238, 244),
                body: RefreshIndicator(
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
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    children: const [
                      Center(
                          child: ErrorDisplay(
                              message: 'Connect to internet. Refresh it.'))
                    ],
                  ),
                ),
              );
            }
            length = state.posts.length;
            return postMainDisplay(context);
          } else {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 236, 238, 244),
              body: RefreshIndicator(
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
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4),
                  children: const [
                    Center(
                        child: ErrorDisplay(
                            message: 'Connect to internet. Refresh it.'))
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget postMainDisplay(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 238, 244),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/images/logo.svg',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "The",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Architect",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Setting(
                            user: widget.user,
                          ),
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: Image.asset(
                          'assets/images/user.png',
                        ).image,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(widget.user.image)),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Search(onChanged: searchPosts),
                const SizedBox(height: 10),
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
                displayPosts(context.read<PostBloc>().state),
              ],
            ),
          ),
        ],
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
              return Post(
                index: index,
                user: widget.user,
                post: state.posts[index],
                posts: state.posts,
              );
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
      padding: const EdgeInsets.only(top: 8.0, bottom: 30),
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
