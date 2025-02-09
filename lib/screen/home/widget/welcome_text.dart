import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// class WelcomeText extends StatefulWidget {
//   const WelcomeText({super.key});

//   @override
//   _WelcomeTextState createState() => _WelcomeTextState();
// }

// class _WelcomeTextState extends State<WelcomeText> {
//   bool _isShimmerActive = true;

//   @override
//   void initState() {
//     super.initState();
//     // Set a timer to stop shimmer effect after 3 seconds
//     Timer(Duration(seconds: 6), () {
//       setState(() {
//         _isShimmerActive = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 6, right: 20, bottom: 10, top: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10,),
//               Row(
//                 children: [
//                   _isShimmerActive
//                       ? Shimmer.fromColors(
//                           baseColor: Colors.black87,
//                           highlightColor: Colors.yellow,
//                           child: Text(" Ghar-", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
//                         )
//                       : Text(" Ghar-", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
//                   _isShimmerActive
//                       ? Shimmer.fromColors(
//                           baseColor: Colors.black87,
//                           highlightColor: Colors.green,
//                           child: Text("BhadaMa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
//                         )
//                       : Text("BhadaMa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
//                 ],
//               ),
//             ],
//           ),
//           CircleAvatar(
//             backgroundImage: AssetImage('assets/b.png'),
//           ),
//         ],
//       ),
//     );
//   }
// }
class WelcomeText extends StatefulWidget {
  final bool isShimmerActive; // Accept shimmer state as a parameter

  const WelcomeText({super.key, required this.isShimmerActive});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    // TODO: implement initState

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 1.0),
      ),
    );

    _animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.45, 1.0),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: EdgeInsets.only(left: 6, right: 4, bottom: 10, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    /// color: Colors.green,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        widget.isShimmerActive
                            ? Transform.translate(
                                offset: Offset(0, (1 - _animation1.value) * 50),
                                child: Opacity(
                                  opacity: _animation1.value,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.green,
                                    highlightColor: Colors.yellow,
                                    child: Row(
                                children: [
                                  Text("G",
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("h",
                                      style: TextStyle(
                                          color: Colors.green.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("a",
                                      style: TextStyle(
                                          color: Colors.red.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("r",
                                      style: TextStyle(
                                          color: Colors.yellow.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                ],
                              ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Text(" G",
                                      style: TextStyle(
                                          color: Colors.blue.shade600,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("h",
                                      style: TextStyle(
                                          color: Colors.green.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("a",
                                      style: TextStyle(
                                          color: Colors.red.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("r",
                                      style: TextStyle(
                                          color: Colors.yellow.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                ],
                              ),
                        widget.isShimmerActive
                            ? Transform.translate(
                                offset: Offset(0, (1 - _animation1.value) * 50),
                                child: Opacity(
                                  opacity: _animation1.value,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.green,
                                    highlightColor: Colors.yellow,
                                    child: Row(
                              children: [
                                Text("B",
                                    style: TextStyle(
                                        color: Colors.pink.shade900,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40)),
                                        Text("h",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("a",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("d",
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("a",
                            style: TextStyle(
                                color: Colors.orange.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("M",
                            style: TextStyle(
                                color: Colors.purple.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("a",
                            style: TextStyle(
                                color: Colors.lightBlue.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                              ],
                            ),
                                  ),
                                ),
                              )
                            : Row(
                              children: [
                                Text("B",
                                    style: TextStyle(
                                        color: Colors.pink.shade900,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40)),
                                        Text("h",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("a",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("d",
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("a",
                            style: TextStyle(
                                color: Colors.orange.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("M",
                            style: TextStyle(
                                color: Colors.purple.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        Text("a",
                            style: TextStyle(
                                color: Colors.lightBlue.shade900,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                              ],
                            ),
                        
                        SizedBox(
                          width: width * 0.180,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/b.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
