import 'package:flutter/material.dart';

import 'chat_item.dart';
import 'chat_pompt_tags/function.dart';
import 'chat_pompt_tags/pomptTag.dart';

class ChatSideBar extends StatefulWidget {
  const ChatSideBar({Key? key}) : super(key: key);

  @override
  State<ChatSideBar> createState() => _ChatSideBarState();
}

class _ChatSideBarState extends State<ChatSideBar> {
  List<Icon> icons = [
    const Icon(Icons.landscape),
    const Icon(Icons.view_in_ar_outlined),
    const Icon(Icons.rectangle_outlined),
    const Icon(Icons.ads_click_rounded),
    const Icon(Icons.build_circle_outlined),
    const Icon(Icons.cyclone),
    const Icon(Icons.cyclone),
    const Icon(Icons.cyclone),
    const Icon(Icons.cyclone),
    const Icon(Icons.cyclone),
    const Icon(Icons.cyclone),
  ];

  List<String> titles = [
    "View",
    "Exterior Style",
    "Exterior Function",
    "Weather",
    "Enviroment",
    "Exterior Material",
    "Spatial Composition",
    "Interior Function",
    "Interior Style",
    "Interior Material",
    "Wall Material"
  ];

  List<String> view = [
    "elevation",
    "perspective",
    "aerial view",
    "street view",
    "close shot",
    "mid shot",
    "distant shot",
  ];

  List<String> exteriorStyle = [
    "Modern",
    "Ancient Greece",
    "New Chinese",
    "Neoclassical",
    "Deconstructism",
    "Curved",
    "Futuristic",
    "Minimalism",
    "Natural",
    "Geometrical stacking",
    "Dynamic",
    "Experimental",
    "Conceptual",
    "Green Architecture",
    "Cyberpunk",
    "Postmodernism",
    "Brutalism",
    "Industrial",
    "Surrealism",
    "Mediterranean",
    "American",
    "Gothic",
    "Rococo",
    "Bauhaus",
    "Art Deco",
    "Medieval",
  ];

  Map<String, List<String>> functions = {
    "Residential Building": [
      "high rise",
      "super high rise",
      "mid rise",
      "villa",
      "countryside villa building",
      "apartment building",
      "community center",
      "sales center",
      "building group",
    ],
    "Office Building": [
      "skyscraper",
      "high rise",
      "mid rise",
      "low rise",
      "building group",
    ],
    "Public Building": [
      "high rise",
      "mid rise",
      "low rise",
      "theater",
      "library",
      "museum",
      "activity center",
      "exhibition center",
      "stadium",
      "school",
      "train station",
    ],
    "Industry": [
      "park",
    ],
    "Commercial Building": [
      "street",
      "hotel",
      "complex",
    ],
  };

  List<String> weather = [
    "sunny",
    "dusk",
    "night",
    "cloudy",
    "foggy",
    "dawn",
    "rainy",
    "snowy",
  ];

  List<String> enviroment = [
    "street",
    "landscape",
    "sidewalk",
    "pool",
    "light details",
    "podium",
    "commercial atmosphere",
    "plaza",
  ];

  List<String> exteriorMaterial = [
    "glass curtain wall",
    "stone",
    "marble",
    "granite",
    "metal",
    "wood",
    "brick",
    "red brick",
    "gray brick",
    "polished concrete",
    "fair-faced concrete",
    "metal plate",
    "paint coating",
    "membrane structure",
    "steel",
  ];

  List<String> spatialComposition = [
    "curved shape",
    "staggered volumes",
    "bionic structure",
    "linear form",
    "free form",
    "geometric form",
    "parametric envelope",
    "landscape integrated",
  ];

  Map<String, List<String>> functionInteriorStyles = {
    "Residential Interior": [
      "living room",
      "bedroom",
      "kitchen",
      "dining room",
      "bathroom",
      "terrace",
      "study room",
      "closet",
    ],
    "Public Interior": [
      "office",
      "lobby",
      "sales center",
    ],
    "Commercial Interior": [
      "shop",
      "restaurant",
      "education",
      "hair salon",
      "internet café",
      "exhibition",
      "shopping mall",
      "bookstore",
    ],
  };

  static List<String> interiorStyle = [
    "Modern style",
    "European Classic style",
    "New Chinese style",
    "Nordic style",
    "Japanese style",
    "American style",
    "Industrial style",
    "Minimalism style",
    "Futuristic style",
    "Traditional Chinese style",
    "Luxury style",
    "Rococo style",
  ];

  List<String> wallMaterial = [
    "painted wall",
    "wallpaper wall",
    "panel wall",
    "stone wall",
    "tile wall",
    "wood wall",
  ];

  List<String> floorMaterial = [
    "marble",
    "tile",
    "carpet",
    "brick",
    "concrete",
    "cement",
    "rubber",
    "wood",
  ];

  final List<String> selectedExterior = [];
  final List<String> selectedFunction = [];
  final List<String> selectedView = [];
  final List<String> selectedWeather = [];
  final List<String> selectedEnviroment = [];
  final List<String> selectedExteriorMaterial = [];
  final List<String> selectedSpatialComposition = [];
  final List<String> selectedInteriorfunction = [];
  final List<String> selectedInteriorStyle = [];
  final List<String> selectedWallMaterial = [];
  final List<String> selectedFloorMaterial = [];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      PomptTag(pomptTagStyle: view, selectedPomptTag: selectedView),
      PomptTag(
          pomptTagStyle: exteriorStyle, selectedPomptTag: selectedExterior),
      FunctionForm(
          functionStyle: functions, selectedFunction: selectedFunction),
      PomptTag(pomptTagStyle: weather, selectedPomptTag: selectedWeather),
      PomptTag(pomptTagStyle: enviroment, selectedPomptTag: selectedEnviroment),
      PomptTag(
          pomptTagStyle: exteriorMaterial,
          selectedPomptTag: selectedExteriorMaterial),
      PomptTag(
          pomptTagStyle: spatialComposition,
          selectedPomptTag: selectedSpatialComposition),
      FunctionForm(
          functionStyle: functionInteriorStyles,
          selectedFunction: selectedInteriorfunction),
      PomptTag(
          pomptTagStyle: interiorStyle,
          selectedPomptTag: selectedInteriorStyle),
      PomptTag(
          pomptTagStyle: exteriorMaterial,
          selectedPomptTag: selectedExteriorMaterial),
      PomptTag(
          pomptTagStyle: wallMaterial, selectedPomptTag: selectedWallMaterial),
      PomptTag(
          pomptTagStyle: floorMaterial,
          selectedPomptTag: selectedFloorMaterial),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int i = 0; i < icons.length; i++)
            ChatItem(
              body: widgets[i],
              index: i,
              isSelected: i == selectedIndex,
              title: titles[i],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              icon: icons[i],
            ),
        ],
      ),
    );
  }
}
