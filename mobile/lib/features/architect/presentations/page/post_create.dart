import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/page/home.dart';
import 'package:architect/features/architect/presentations/widget/error.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../domains/entities/user.dart';
import '../widget/tag.dart';

class CreatePostPage extends StatefulWidget {
  final User user;
  final String imageUrl;
  final Post? post;

  const CreatePostPage({
    required this.user,
    required this.imageUrl,
    this.post,
    Key? key,
  }) : super(key: key);

  static const String name = '/post/create';

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final List<String> tags = [
    "exterior",
    "facade",
    "outdoor",
    "landscape",
    "architectural facade",
    "outdoor design",
    "interior",
    "indoor",
    "interior design",
    "space planning",
    "furniture design",
    "decor",
    "lighting"
  ];

  late Post post;
  final Set<String> selectedTags = {};

  bool isSelected(String tag) => selectedTags.contains(tag);

  void onPressedTag(String tag) {
    if (isSelected(tag)) {
      setState(() {
        selectedTags.remove(tag);
      });
    } else {
      setState(() {
        selectedTags.add(tag);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _descriptionController.text = widget.post!.content;
      selectedTags.addAll(widget.post!.tags);
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<PostBloc>(),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 236, 238, 244),
          body: SingleChildScrollView(
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                if (state.otherPostStatus == PostStatus.success) {
                  Navigator.popUntil(context, (route) {
                    return route.runtimeType == HomePage;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        user: widget.user,
                      ),
                    ),
                  );
                } else if (state.otherPostStatus == PostStatus.loading) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SpinKitThreeBounce(
                        size: 25,
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state.otherPostStatus == PostStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          ErrorDisplay(message: 'Unknown error while posting!'),
                    ),
                  );
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Image.network(
                                widget.imageUrl,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xff22c55e),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 40,
                                width: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.5 - 50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 238, 244),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: tags.map((e) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Tag(
                                        isSelected: isSelected(e),
                                        text: e,
                                        onPressed: onPressedTag,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextField(
                                      controller: _titleController,
                                      decoration: const InputDecoration(
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Title',
                                      ),
                                      onChanged: (value) => setState(
                                            () {
                                              _titleController.text = value;
                                            },
                                          )),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: _descriptionController,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Description',
                                    ),
                                    onChanged: (value) => setState(
                                      () {
                                        _descriptionController.text = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BlocBuilder<PostBloc, PostState>(
                                        builder: (context, state) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              if (widget.post != null) {
                                                Post xxx = widget.post!;
                                                BlocProvider.of<PostBloc>(
                                                        context)
                                                    .add(
                                                  EditPostEvent(
                                                    userId: widget.user.id,
                                                    image: widget.imageUrl,
                                                    postId: xxx.id,
                                                    title:
                                                        _titleController.text,
                                                    content:
                                                        _descriptionController
                                                            .text,
                                                    tags: selectedTags.toList(),
                                                  ),
                                                );
                                              } else {
                                                BlocProvider.of<PostBloc>(
                                                        context)
                                                    .add(
                                                  CreatePostEvent(
                                                    image: widget.imageUrl,
                                                    title:
                                                        _titleController.text,
                                                    content:
                                                        _descriptionController
                                                            .text,
                                                    tags: selectedTags.toList(),
                                                    userId: widget.user.id,
                                                  ),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xff22c55e),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.send_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Text(
                                                    widget.post != null
                                                        ? 'Update'
                                                        : 'Post',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
