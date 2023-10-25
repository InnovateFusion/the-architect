import 'dart:convert';
import 'dart:io';

import 'package:architect/features/architect/domains/entities/message.dart'
    as message;
import 'package:architect/features/architect/presentations/bloc/chat/chat_bloc.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_display.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_side_bar.dart';
import 'package:architect/features/architect/presentations/widget/drawer.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/type/type_bloc.dart';
import '../widget/chat/chat_input.dart';
import '../widget/profile_image.dart';

class Message {
  final String prompt;
  final bool isSentByMe;
  final bool isPicked;
  final String imageUser;
  final String imageAI;
  final String model;
  final Map<String, dynamic> analysis;
  final Map<String, dynamic> threeD;
  final String chat;

  Message({
    required this.prompt,
    required this.isSentByMe,
    required this.imageUser,
    required this.imageAI,
    required this.model,
    required this.analysis,
    required this.threeD,
    required this.chat,
    required this.isPicked,
  });
}

class Chat extends StatefulWidget {
  const Chat({
    Key? key,
    this.messages,
    this.chatId,
    this.userId,
    this.contollerImage,
    this.paintingImage,
    this.maskImage,
  }) : super(key: key);

  final List<message.Message>? messages;
  final String? chatId;
  final String? userId;
  final String? contollerImage;
  final String? paintingImage;
  final String? maskImage;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages = [];
  String? chatId;
  String model = 'text_to_image';
  late TypeBloc _select;
  late String base64ImageForImageToImage;
  late String base64ImageForControlNet;

  @override
  void initState() {
    super.initState();

    _select = sl<TypeBloc>();
    _select.add(GetType());
    _select.stream.listen((event) {
      if (event is TypeLoaded) {
        setState(() {
          model = event.model.name;
        });
      }
    });

    if (widget.messages != null) {
      for (var message in widget.messages!) {
        if (message.sender == 'ai') {
          final Message element = Message(
              prompt: message.content['prompt'] ?? '',
              isSentByMe: false,
              imageUser: message.content['imageUser'] ?? '',
              imageAI: message.content['imageAI'] ?? '',
              model: message.content['model'] ?? '',
              analysis: message.content['analysis'] ?? {},
              threeD: message.content['3D'] ?? {},
              chat: message.content['chat'] ?? '',
              isPicked: false);
          messages.insert(0, element);
        } else {
          final Message element = Message(
              prompt: message.content['prompt'] ?? '',
              isSentByMe: true,
              imageUser: message.content['imageUser'] ?? '',
              imageAI: message.content['imageAI'] ?? '',
              model: message.content['model'] ?? '',
              analysis: message.content['analysis'] ?? {},
              threeD: message.content['3D'] ?? {},
              chat: message.content['chat'] ?? '',
              isPicked: false);
          messages.insert(0, element);
        }
      }
    } else {
      messages = [];
      chatId = widget.chatId;
    }
  }

  Future<String> imageToBase64(String imagePath) async {
    final File imageFile = File(imagePath);

    if (await imageFile.exists()) {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } else {
      return '';
    }
  }

  void handleSubmitted(BuildContext context, String text) {
    var payload = {
      "model": "stable-diffusion-v1-5",
      "prompt": text,
      "negative_prompt": "Disfigured, cartoon, blurry",
      "width": 512,
      "height": 512,
      "steps": 25,
      "guidance": 7.5,
      "seed": 0,
      "scheduler": "dpmsolver++",
      "output_format": "jpeg"
    };

    if (text.isEmpty) return;

    if (model == 'image_to_image') {
      if ((messages.isNotEmpty && !messages[0].isPicked) || messages.isEmpty) {
        return;
      } else {
        payload['image'] = base64ImageForImageToImage;
      }
    } else if (model == 'controlNet') {
      payload["controlnet"] = "canny-1.1";
      payload["image"] = base64ImageForControlNet;
    }

    _select.stream.listen((event) {
      if (event is TypeLoaded) {
        model = event.model.name;
      }
    });

    if (chatId != null) {
      BlocProvider.of<ChatBloc>(context).add(MakeChatEvent(
        userId: widget.userId ?? "35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a",
        payload: payload,
        chatId: chatId!,
        model: model,
      ));
    } else {
      BlocProvider.of<ChatBloc>(context).add(ChatCreateEvent(
        userId: "35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a",
        payload: payload,
        model: model,
      ));
    }
    setState(() {
      messages.insert(
        0,
        Message(
            prompt: text,
            isSentByMe: true,
            imageUser: '',
            imageAI: '',
            model: model,
            analysis: {},
            threeD: {},
            chat: '',
            isPicked: false),
      );
    });
  }

  void reveiveMessage(Map<String, dynamic> json) {
    setState(() {
      messages.insert(
        0,
        Message(
            prompt: json['prompt'],
            isSentByMe: false,
            imageUser: json['imageUser'],
            imageAI: json['imageAI'],
            model: json['model'],
            analysis: json['analysis'],
            threeD: json['3D'],
            chat: json['chat'],
            isPicked: false),
      );
    });
  }

  void selectedDesign(String select) {
    model = select;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        if (messages.isNotEmpty) {
          if (messages[0].isPicked) {
            messages.removeAt(0);
          }
          messages.insert(
            0,
            Message(
                prompt: '',
                isSentByMe: true,
                imageUser: pickedImage.path,
                imageAI: '',
                model: model,
                analysis: {},
                threeD: {},
                chat: '',
                isPicked: true),
          );
        }
      });
      base64ImageForImageToImage = await imageToBase64(pickedImage.path);
    }
  }

  Future<void> getControllImage(String imagePath) async {
    if (imagePath.isEmpty) return;
    setState(() {
      messages.insert(
        0,
        Message(
            prompt: '',
            isSentByMe: true,
            imageUser: imagePath,
            imageAI: '',
            model: model,
            analysis: {},
            threeD: {},
            chat: '',
            isPicked: true),
      );
    });

    base64ImageForControlNet = await imageToBase64(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TypeBloc>(
            create: (context) => _select,
          ),
          BlocProvider<ChatBloc>(
              create: (context) => sl<ChatBloc>()
                ..add(const ChatViewEvent(
                    id: '35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a'))),
        ],
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          drawer: Drawer(
            child: CustomDrawer(
              onSelect: selectedDesign,
            ),
          ),
          body: BlocBuilder<TypeBloc, TypeState>(builder: (ctx, state) {
            if (state is TypeLoaded) {
              model = state.model.name;
            }
            return Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(5)),
                            height: 40,
                            width: 40,
                            child: GestureDetector(
                              onTap: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Chat",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      const ProfileImage(
                          imageUrl: 'assets/images/me.jpg', size: 50.0),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const ChatSideBar(),
                        BlocListener<ChatBloc, ChatState>(
                          listener: (context, state) {
                            if (state is MakeChatLoaded) {
                              reveiveMessage(state.message.content);
                            } else if (state is ChatCreateLoaded) {
                              chatId = state.chat.id;
                              for (int i = 0;
                                  i < state.chat.messages.length;
                                  i++) {
                                if (state.chat.messages[i].sender == 'ai') {
                                  reveiveMessage(
                                      state.chat.messages[i].content);
                                }
                              }
                            }
                          },
                          child: ChatDisplay(messages: messages),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ChatInput(
                    model: model,
                    onImagePick: _pickImage,
                    onSubmitted: handleSubmitted,
                    onControNet: getControllImage,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
