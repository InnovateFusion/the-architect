import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/type/type_bloc.dart';
import '../page/history.dart';
import 'profile_image.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  final Function(String select) onSelect;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String current = "";
  late TypeBloc _select;

  @override
  void initState() {
    super.initState();
    _select = sl<TypeBloc>();
    _select.add(GetType());
    _select.stream.listen((event) {
      if (event is TypeLoaded) {
        setState(() {
          current = event.model.name;
        });
      }
    });
  }

  void onSelected(String index) {
    setState(() {
      current = index;
    });
    _select.add(SetType(model: index));
    widget.onSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _select,
      child: ListView(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                ProfileImage(
                  imageUrl: "assets/images/me.jpg",
                  size: 70,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Muhammad Fadhil",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 35,
              top: 10,
              bottom: 10,
            ),
            child: const Text(
              "Type of Design",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: BlocBuilder<TypeBloc, TypeState>(
              builder: (context, state) {
                if (state is TypeLoaded) {
                  current = state.model.name;
                }
                return ListBody(
                  children: [
                    ListTile(
                      leading: Switch(
                        value: current == "text_to_image",
                        onChanged: (newValue) {
                          onSelected('text_to_image');
                        },
                      ),
                      title: const Text(
                        "Text to Image",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Switch(
                        value: current == "image_to_image",
                        onChanged: (newValue) {
                          onSelected('image_to_image');
                        },
                      ),
                      title: const Text(
                        "Image to Image",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Switch(
                        value: current == "controlNet",
                        onChanged: (newValue) {
                          onSelected('controlNet');
                        },
                      ),
                      title: const Text(
                        "Control Net",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Switch(
                        value: current == "painting",
                        onChanged: (newValue) {
                          onSelected('painting');
                        },
                      ),
                      title: const Text(
                        "Painting",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListBody(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const History(),
                      ),
                    );
                  },
                  leading: const Icon(Icons.history),
                  title: const Text(
                    "History",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "About",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
