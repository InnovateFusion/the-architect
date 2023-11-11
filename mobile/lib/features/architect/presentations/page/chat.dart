import 'dart:convert';
import 'dart:io';

import 'package:architect/features/architect/data/models/message.dart';
import 'package:architect/features/architect/domains/entities/message.dart'
    as message;
import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:architect/features/architect/presentations/bloc/chat/chat_bloc.dart';
import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_display.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_side_bar.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/util/get_image_base64.dart';
import '../../domains/entities/team.dart';
import '../../domains/entities/user.dart';
import '../bloc/type/type_bloc.dart';
import '../widget/chat/chat_input.dart';

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
  final String? image;
  final bool? isTeam;

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
    this.image,
    this.isTeam = false,
  });
}

List<String> modelsX = [
  "new_chat",
  "history",
  'image_from_text',
  "image_to_image",
  "instruction",
  "controlNet",
  "edit_image",
  "image_variant",
  "text_to_3D",
  "chatbot",
  "analysis",
];

class Chat extends StatefulWidget {
  const Chat({
    Key? key,
    this.messages,
    required this.user,
    this.team,
    this.draw,
    this.replay,
    this.messageX,
    this.post,
  }) : super(key: key);

  final List<message.Message>? messages;
  final Map<String, String>? draw;
  final User user;
  final Post? post;
  final Message? replay;
  final Team? team;
  final List<Message>? messageX;

  @override
  State<Chat> createState() => _ChatState();

  static const String name = '/chat';
}

class _ChatState extends State<Chat> {
  List<Message> messages = [];
  String? chatId;
  String model = 'text_to_image';
  late TypeBloc _select;
  late String base64ImageForImageToImage;
  late String base64ImageForControlNet;
  final IO.Socket socket = IO.io(
    'https://sketch-dq5zwrwm5q-ww.a.run.app',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  )..connect();
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
              image: message.content.containsKey('image')
                  ? message.content['image']
                  : widget.user.image,
              isTeam: widget.team != null ? true : false,
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
              image: message.content.containsKey('image')
                  ? message.content['image']
                  : widget.user.image,
              isTeam: widget.team != null ? true : false,
              isPicked: false);
          messages.insert(0, element);
        }
      }
    } else {
      messages = [];
    }
    if (widget.replay != null) {
      messages = widget.messageX!;
      startFromReply();
    }
    if (widget.post != null) {
      startFromPost();
    }
    if (widget.draw != null) {
      startInt();
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
    if (model == 'analysis') {
      payload['text'] = '${payload['text']}.';
    }

    if (model == 'image_to_image' ||
        model == 'image_variant' ||
        model == 'analysis' ||
        model == 'instruction') {
      if ((messages.isNotEmpty && !messages[0].isPicked) || messages.isEmpty) {
        return;
      } else {
        payload['image'] = base64ImageForImageToImage;
      }
    } else if (model == 'controlNet') {
      payload["controlnet"] = "canny-1.1";
      payload["image"] = base64ImageForControlNet;
    }

    if (model == 'image_to_image') {
      payload["strength"] = 0.5;
      payload["steps"] = 50;
    }

    if (model == 'instruction') {
      payload['model'] = "instruct-pix2pix";
      payload["image_guidance"] = 1.5;
      payload["seed"] = 0;
      payload["scheduler"] = "euler_a";
    }

    if (model == 'edit_image' && base64ImageForImageToImage.isNotEmpty) {
      payload['image'] = base64ImageForImageToImage;
      payload['mask'] = base64ImageForControlNet;
    }

    _select.stream.listen((event) {
      if (event is TypeLoaded) {
        model = event.model.name;
      }
    });

    if (chatId != null) {
      BlocProvider.of<ChatBloc>(context).add(MakeChatEvent(
        userId: widget.user.id,
        payload: payload,
        chatId: chatId!,
        model: model,
      ));
    } else if (widget.team != null) {
      BlocProvider.of<ChatBloc>(context).add(MakeChatEvent(
        userId: widget.user.id,
        payload: payload,
        chatId: widget.team!.id,
        isTeam: true,
        model: model,
      ));
    } else {
      BlocProvider.of<ChatBloc>(context).add(ChatCreateEvent(
        userId: widget.user.id,
        payload: payload,
        model: model,
      ));
    }
    setState(() {
      if (messages.isNotEmpty) {
        if (!messages[0].isPicked) {
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
                isTeam: false,
                image: widget.user.image,
                isPicked: false),
          );
        } else {
          final Message element = Message(
              prompt: text,
              isSentByMe: true,
              imageUser: messages[0].imageUser,
              imageAI: '',
              model: model,
              analysis: {},
              threeD: {},
              chat: 'x',
              isTeam: false,
              image: widget.user.image,
              isPicked: false);
          messages[0] = element;
        }
      } else {
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
              isPicked: false,
              isTeam: false,
              image: widget.user.image),
        );
      }
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
            isTeam: false,
            image: widget.user.image,
            isPicked: false),
      );
    });
  }

  void selectedDesign(int index) {
    if (index == 0) {
      setState(() {
        messages.clear();
        chatId = null;
      });
    } else {
      final String select = modelsX[index];
      _select.add(SetType(model: select));
      model = select;
    }
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
                isPicked: true,
                isTeam: false,
                image: widget.user.image),
          );
        } else {
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
                isTeam: false,
                image: widget.user.image,
                chat: '',
                isPicked: true),
          );
        }
      });
      base64ImageForImageToImage = await imageToBase64(pickedImage.path);
    }
  }

  Future<void> getControllImage(Map<String, dynamic> data) async {
    if (data['sketch'].isEmpty) return;
    setState(() {
      messages.insert(
        0,
        Message(
            prompt: '',
            isSentByMe: true,
            imageUser: data['sketch'],
            imageAI: '',
            model: model,
            analysis: {},
            threeD: {},
            isTeam: false,
            image: widget.user.image,
            chat: '',
            isPicked: true),
      );
    });

    base64ImageForControlNet = await imageToBase64(data['sketch']);
    if (data['backgroundImage'].isEmpty) return;
    base64ImageForImageToImage = await imageToBase64(data['backgroundImage']);
  }

  Future<void> startFromReply() async {
    if (widget.replay != null) {
      String? ximage = await getImageAsBase64(widget.replay!.imageAI);
      if (ximage != null) {
        setState(() {
          messages.insert(
            0,
            Message(
                prompt: '',
                isSentByMe: true,
                imageUser: ximage,
                imageAI: 'xxx',
                model: model,
                isTeam: false,
                image: widget.user.image,
                analysis: {},
                threeD: {},
                chat: '',
                isPicked: true),
          );
        });

        base64ImageForImageToImage = await imageToBase64(ximage);
      }
    }
  }

  Future<void> startFromPost() async {
    if (widget.post != null) {
      Post xpost = widget.post!;
      String? ximage = await getImageAsBase64(xpost.image);
      if (ximage != null) {
        setState(() {
          messages.insert(
            0,
            Message(
                prompt: '',
                isSentByMe: true,
                imageUser: ximage,
                imageAI: '',
                model: model,
                analysis: {},
                threeD: {},
                isTeam: false,
                image: widget.user.image,
                chat: '',
                isPicked: true),
          );
        });

        base64ImageForImageToImage = await imageToBase64(ximage);
      }
    }
  }

  void startInt() async {
    if (widget.draw != null) {
      String backgroundX = widget.draw!['backgroundImage'] ?? '';
      String sketchX = widget.draw!['sketch'] ?? '';
      if (backgroundX.isEmpty) {
        model == 'edit_image';
        messages.insert(
          0,
          Message(
              prompt: '',
              isSentByMe: true,
              imageUser: sketchX,
              imageAI: '',
              model: model,
              isTeam: false,
              image: widget.user.image,
              analysis: {},
              threeD: {},
              chat: '',
              isPicked: true),
        );
        base64ImageForControlNet = await imageToBase64(backgroundX);
      } else {
        model == 'controlNet';
        messages.insert(
          0,
          Message(
              prompt: '',
              isSentByMe: true,
              imageUser: sketchX,
              imageAI: '',
              model: model,
              analysis: {},
              isTeam: false,
              image: widget.user.image,
              threeD: {},
              chat: '',
              isPicked: true),
        );
      }
      base64ImageForImageToImage = await imageToBase64(sketchX);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    if (widget.replay != null) {
      final xxx = messages.removeAt(0);
      messages.insert(
        0,
        Message(
            prompt: xxx.prompt,
            isSentByMe: xxx.isSentByMe,
            imageUser: xxx.imageUser,
            imageAI: xxx.imageAI,
            model: xxx.model,
            analysis: xxx.analysis,
            threeD: xxx.threeD,
            chat: xxx.chat,
            isTeam: false,
            image: widget.user.image,
            isPicked: xxx.isPicked),
      );
    }

    socket.onConnect((_) {
      if (widget.team != null) {
        socket.on('teams-chat-${widget.team!.id}', (data) {
          final json = jsonDecode(data);
          final jsonModel = MessageModel.fromJson(json);
          reveiveMessage(jsonModel.content);
        });
      }
    });

    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TypeBloc>(
            create: (context) => _select,
          ),
          BlocProvider<ChatBloc>(
              create: (context) =>
                  sl<ChatBloc>()..add(ChatViewEvent(id: widget.user.id))),
        ],
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color.fromARGB(255, 236, 238, 244),
          body: BlocBuilder<TypeBloc, TypeState>(builder: (ctx, state) {
            if (state is TypeLoaded) {
              model = state.model.name;
            }
            return Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (messages.isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff22c55e),
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                          if (messages.isNotEmpty) const SizedBox(width: 10),
                          const Text(
                            "Chat",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Ai",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
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
                            width: 50,
                            height: 50,
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
                  const SizedBox(height: 15),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ChatSideBar(
                          user: widget.user,
                          selectedModel: model,
                          onModelChanged: selectedDesign,
                        ),
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
                            } else if (state is ChatError) {
                              if (widget.replay != null &&
                                  messages[0].imageAI == 'xxx') {
                              } else if (messages.isNotEmpty &&
                                  messages[0].isSentByMe &&
                                  !(messages.length == 1 &&
                                      ((widget.draw != null) ||
                                          (widget.post != null)))) {
                                setState(() {
                                  messages.insert(
                                      0,
                                      Message(
                                          prompt: '',
                                          isSentByMe: false,
                                          imageUser: '',
                                          imageAI: '',
                                          model: model,
                                          analysis: {},
                                          threeD: {},
                                          chat: 'Something went wrong',
                                          isPicked: false));
                                });
                              }
                            }
                          },
                          child: ChatDisplay(
                              messages: messages, user: widget.user),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ChatInput(
                    model: model,
                    user: widget.user,
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
