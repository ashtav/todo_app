import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Poslign(
        alignment: Alignment.topCenter,
        child: Container(
            decoration:
                BoxDecoration(color: Colors.white, border: Br.only(['b'])),
            padding: Ei.only(t: context.viewPadding.top, b: 0, r: 0, l: 20),
            child: Row(
              mainAxisAlignment: Maa.spaceBetween,
              children: [
                const Text('Dashboard'),
                Row(
                  children: [
                    Stack(
                      children: [
                        InkTouch(
                            onTap: () {},
                            padding: Ei.all(20),
                            child: const Icon(Ti.bell)),
                        Poslign(
                          alignment: Alignment.topLeft,
                          child: RippleAnimation(
                            minRadius: 20,
                            repeat: true,
                            ripplesCount: 3,
                            color: Colors.red,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle),
                            ),
                          ).margin(all: 13).lz.ignore(),
                        )
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
