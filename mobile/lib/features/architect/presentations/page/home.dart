import 'package:architect/features/architect/domains/entities/post.dart'
    as post;
import 'package:architect/features/architect/presentations/widget/post/post.dart';
import 'package:architect/injection_container.dart';
<<<<<<< HEAD
import 'package:flutter_spinkit/flutter_spinkit.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
>>>>>>> ccf8b2c (:boom: add new feature)

import '../bloc/post/post_bloc.dart';
import '../widget/custom_bottom_navigation.dart';
import '../widget/profile_image.dart';
import '../widget/search.dart';
import 'package:flutter/material.dart';
import '../widget/tag.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
<<<<<<< HEAD
  late PostBloc postBloc;
  final List<post.Post> posts = [];
  final List<post.Post> filteredPosts = [];
  final TextEditingController searchController = TextEditingController();
=======
  var search = '';
  final selectedTags = [];

  void onSearchPressed(int i) {}
>>>>>>> ccf8b2c (:boom: add new feature)

  final List<String> xTags = [
    'Explore',
    'Interior',
    'Exterior',
    'Architecture',
    'Design',
  ];

  final List<String> selectedTags = [
    'Explore',
  ];

  List<Tag> tags = [];

  @override
  void initState() {
    super.initState();
    postBloc = sl<PostBloc>();
    postBloc.add(
      const AllPosts(),
    );
    postBloc.stream.listen((event) {
      if (event is PostsViewsLoaded) {
        setState(() {
          posts.addAll(event.posts);
        });
      }
    });

    for (final tag in xTags) {
      if (selectedTags.contains(tag)) {
        tags.add(
          Tag(
            text: tag,
            isSelected: true,
            onPressed: onSelectedTag,
          ),
        );
      } else {
        tags.add(
          Tag(
            text: tag,
            isSelected: false,
            onPressed: onSelectedTag,
          ),
        );
      }
    }
  }

<<<<<<< HEAD
  void onSelectedTag(String tag) {
    if (selectedTags.contains(tag)) {
      setState(() {
        selectedTags.remove(tag);
        for (int i = 0; i < tags.length; i++) {
          if (tags[i].text == tag) {
            tags[i] = Tag(
              text: tag,
              isSelected: false,
              onPressed: onSelectedTag,
            );
          }
        }
      });
    } else {
      setState(() {
        for (int i = 0; i < tags.length; i++) {
          if (tags[i].text == tag) {
            tags[i] = Tag(
              text: tag,
              isSelected: true,
              onPressed: onSelectedTag,
            );
          }
        }
        selectedTags.add(tag);
      });
    }
    for (final post in posts) {
      int count = 0;
      for (final tag in selectedTags) {
        if (post.tags.contains(tag.toLowerCase())) {
          count++;
        }
      }
      if (count == selectedTags.length) {
        setState(() {
          filteredPosts.add(post);
        });
      }
    }
  }

  void searchPosts(String search) {
    selectedTags.clear();
    setState(() {
      filteredPosts.clear();
      filteredPosts.addAll(posts
          .where(
              (post) => post.title.toLowerCase().contains(search.toLowerCase()))
          .toList());
    });
  }
=======
  final List<Tag> tags = [
    Tag(
        text: 'Explore',
        color: Colors.black,
        textColor: const Color(0xFFE1DBDB),
        textSize: 13,
        onPressed: () {}),
    Tag(
        text: 'Interior',
        color: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black,
        textSize: 13,
        onPressed: () {}),
    Tag(
        text: 'Exterior',
        color: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black,
        textSize: 13,
        onPressed: () {}),
    Tag(
        text: 'Floor',
        color: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black,
        textSize: 13,
        onPressed: () {}),
    // Add more tags as needed
  ];
>>>>>>> ccf8b2c (:boom: add new feature)

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
<<<<<<< HEAD
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Search(
                      searchController: searchController,
                      onChanged: searchPosts,
                    ),
                    const SizedBox(width: 10),
                    const ProfileImage(
                        imageUrl: 'assets/images/me.jpg', size: 50.0),
                  ],
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: tags
                        .map((tag) => GestureDetector(
                              onTap: () => onSelectedTag(tag.text),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: tag,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 15),
                StreamBuilder(
                  stream: postBloc.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<Object> snapshot) {
                    if (snapshot.hasData) {
                      final event = snapshot.data;
                      if (posts.isNotEmpty &&
                          (event is PostLoading || event is PostInitial)) {
                        return listPosts();
                      } else if (event is PostsViewsLoaded) {
                        posts.clear();
                        filteredPosts.clear();
                        posts.addAll(event.posts);
                        return listPosts();
                      } else if (event is PostError) {
                        return Expanded(
                            child: Center(child: Text(event.message)));
                      }
                    }
                    return Expanded(
                      child: Center(
                        child: SpinKitWave(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
=======
      child: BlocProvider(
        create: (context) =>
            sl<PostBloc>()..add(const AllPosts(tags: [], search: '')),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Search(onPressed: () {}),
                          const SizedBox(width: 10),
                          const ProfileImage(
                              imageUrl: 'assets/images/me.jpg', size: 50.0)
                        ],
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: tags
                              .map((tag) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: tag,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              BlocBuilder<PostBloc, PostState>(
                                  builder: (context, state) {
                                if (state is PostInitial) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is PostsViewsLoaded) {
                                  return Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.posts.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Post(
                                              name:
                                                  '${capitalize(state.posts[index].firstName)} ${capitalize(state.posts[index].lastName)}',
                                              date: DateFormat('MMM d y')
                                                  .format(
                                                      state.posts[index].date),
                                              isLiked:
                                                  state.posts[index].isLiked,
                                              isCloned:
                                                  state.posts[index].isCloned,
                                              userImageUrl:
                                                  'assets/images/me.jpg',
                                              imageUrl:
                                                  state.posts[index].image,
                                              likes: state.posts[index].like,
                                              clones: state.posts[index].clone,
                                              onLiked: () {},
                                              onCloned: () {},
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 90),
                                    ],
                                  );
                                } else if (state is PostLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is PostError) {
                                  return const Center(
                                      child: Text('Error loading posts'));
                                } else {
                                  return Container();
                                }
                              })
                            ])),
                      ),
                    ])),
            const Positioned(
                bottom: 10,
                left: 40,
                right: 40,
                child: CustomBottomNavigation(
                    currentNav: 0) // Add custom bottom navigation
>>>>>>> ccf8b2c (:boom: add new feature)
                ),
              ],
            ),
          ),
          const Positioned(
              bottom: 10,
              left: 40,
              right: 40,
              child: CustomBottomNavigation(
                  currentNav: 0) // Add custom bottom navigation
              ),
        ]),
      ),
    );
  }

  Expanded listPosts() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchController.text.isNotEmpty || selectedTags.isNotEmpty
            ? filteredPosts.length
            : posts.length,
        itemBuilder: (context, index) {
          return Post(
              post: searchController.text.isNotEmpty || selectedTags.isNotEmpty
                  ? filteredPosts[index]
                  : posts[index]);
        },
      ),
    );
  }
}
