import 'package:flutter/material.dart';

class PremierPage extends StatelessWidget {
  const PremierPage({
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
                      'Premier',
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
                    "In the near future, our AI Architect Assistant will continue to offer its full range of features completely free of charge. Architects and design enthusiasts will have the opportunity to explore, experiment, and create using the assistant without any financial commitment for the initial three months of usage. During this time, users can take full advantage of the tool's image and 3D model generation capabilities, along with access to the chat and social media functions to connect and share their work with peers.",
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
                    "However, after the three-month introductory period, we will be introducing a premium subscription model. This premium subscription will unlock a host of additional features and benefits, offering an even more immersive and versatile experience for our users. By subscribing to our premium service, architects can expect exclusive access to advanced AI-driven design tools, enhanced customization options, and priority support. The premium subscription is designed to cater to the specific needs of professional architects and those looking for an elevated level of service.",
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
                    "Rest assured, our commitment to fostering innovation and creativity remains steadfast. We will continue to provide value to all users, whether free or premium, and our goal is to ensure that architects worldwide can harness the power of AI to bring their architectural visions to life with ease and efficiency.",
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
