import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(5),
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
                    const Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "The AI Architect Assistant is a groundbreaking project that is revolutionizing the field of architecture and design. This cutting-edge tool empowers architects by offering a diverse range of features that streamline their workflow, enhance creativity, and foster collaboration within the architectural community.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "First and foremost, the AI Architect Assistant leverages advanced artificial intelligence algorithms to generate stunning images and intricate 3D models. Architects can simply input their design concepts, and the assistant transforms these ideas into visually compelling representations. This not only accelerates the design process but also allows architects to visualize and refine their projects with greater ease and precision.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Additionally, the AI Architect Assistant provides a unique social platform for architects to connect, share, and collaborate. The integrated chat and social media features enable architects to engage in discussions, exchange ideas, and showcase their generated images. This collaborative aspect fosters a sense of community and promotes the cross-pollination of innovative architectural concepts. Ultimately, the AI Architect Assistant is poised to redefine the way architects work, offering them a powerful tool that enhances creativity, efficiency, and connectivity within the industry.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
