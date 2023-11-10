import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven
                  ? const Color.fromARGB(255, 200, 198, 198)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
          );
        },
      ),
    );
  }
}
