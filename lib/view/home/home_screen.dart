import 'dart:developer';
import 'dart:io';

import 'package:audiobook/constants/common_functions.dart';
import 'package:audiobook/view/play_audio/play_audio_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/colors.dart';
import '../../utils/local_audio_sources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.08),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * .03,
              vertical: height * .012,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradientColor,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * .8,
                  child: TextField(
                    onTap: () {
                      log('Redirecting you to search product screen');
                    },
                    cursorColor: black,
                    decoration: InputDecoration(
                      fillColor: white,
                      filled: true,
                      hintText: 'Search audiobooks, writers',
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: black,
                        onPressed: () {},
                      ),
                      suffixIcon: Container(
                        width: width * .15,
                        child: Row(
                          children: [
                            Text(
                              '|',
                              style: TextStyle(fontSize: 25),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.mic,
                                color: Colors.grey,
                              ),
                              color: black,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * .03,
                        // vertical: height
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CommonFunctions.blankSpace(height * .001, 0),
              HomeScreenAddressBar(height: height, width: width),
              CommonFunctions.blankSpace(height * .003, 0),
              Container(
                width: width * .8,
                height: height * .09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Songs',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: width * .09,
                          height: height * .01,
                          decoration: BoxDecoration(
                            color: purpleDark,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Artists'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Albums'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Forders'),
                      ],
                    ),
                  ],
                ),
              ),
              CommonFunctions.blankSpace(height * .003, 0),
              Container(
                height: height*.8,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return   GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayAudioBookScreen(index: index,),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: width,
                        child: Row(
                          children: [
                            Container(
                              width: width * .3,
                              height: width * .3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/book.png'),
                                ),
                              ),
                              child: Image.asset('assets/images/book.png'),
                            ),
                            Container(
                              width: width * .4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    books[index],
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book_authors[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.arrowshape_turn_up_right)),
                            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PlayAudioBookScreen(),
              //       ),
              //     );
              //   },
              //   child: SizedBox(
              //     width: width,
              //     child: Row(
              //       children: [
              //         Container(
              //           width: width * .3,
              //           height: width * .3,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: AssetImage('assets/images/book.png'),
              //             ),
              //           ),
              //           child: Image.asset('assets/images/book.png'),
              //         ),
              //         Container(
              //           width: width * .4,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "Dunyoning ishlari",
              //                 style: TextStyle(
              //                   fontSize: 23,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               Text(
              //                 "O'tkir Hoshimov",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontSize: 15,
              //                   color: grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IconButton(
              //             onPressed: () {},
              //             icon: Icon(CupertinoIcons.arrowshape_turn_up_right)),
              //         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              //       ],
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PlayAudioBookScreen(),
              //       ),
              //     );
              //   },
              //   child: SizedBox(
              //     width: width,
              //     child: Row(
              //       children: [
              //         Container(
              //           width: width * .3,
              //           height: width * .3,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: AssetImage('assets/images/book.png'),
              //             ),
              //           ),
              //           child: Image.asset('assets/images/book.png'),
              //         ),
              //         Container(
              //           width: width * .4,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "Mehrobdan chayon",
              //                 style: TextStyle(
              //                   fontSize: 23,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               Text(
              //                 "Abdulla Qodiriy",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontSize: 15,
              //                   color: grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IconButton(
              //             onPressed: () {},
              //             icon: Icon(CupertinoIcons.arrowshape_turn_up_right)),
              //         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              //       ],
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PlayAudioBookScreen(),
              //       ),
              //     );
              //   },
              //   child: SizedBox(
              //     width: width,
              //     child: Row(
              //       children: [
              //         Container(
              //           width: width * .3,
              //           height: width * .3,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: AssetImage('assets/images/book.png'),
              //             ),
              //           ),
              //           child: Image.asset('assets/images/book.png'),
              //         ),
              //         Container(
              //           width: width * .4,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "O'gay ona",
              //                 style: TextStyle(
              //                   fontSize: 23,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               Text(
              //                 "Ahmad Lutfiy Qozonchi",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontSize: 15,
              //                   color: grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IconButton(
              //             onPressed: () {},
              //             icon: Icon(CupertinoIcons.arrowshape_turn_up_right)),
              //         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              //       ],
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PlayAudioBookScreen(),
              //       ),
              //     );
              //   },
              //   child: SizedBox(
              //     width: width,
              //     child: Row(
              //       children: [
              //         Container(
              //           width: width * .3,
              //           height: width * .3,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: AssetImage('assets/images/book.png'),
              //             ),
              //           ),
              //           child: Image.asset('assets/images/book.png'),
              //         ),
              //         Container(
              //           width: width * .4,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "O'nta negr bolasi",
              //                 style: TextStyle(
              //                   fontSize: 23,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               Text(
              //                 "Agata Kristi",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontSize: 15,
              //                   color: grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IconButton(
              //             onPressed: () {},
              //             icon: Icon(CupertinoIcons.arrowshape_turn_up_right)),
              //         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              //       ],
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PlayAudioBookScreen(),
              //       ),
              //     );
              //   },
              //   child: SizedBox(
              //     width: width,
              //     child: Row(
              //       children: [
              //         Container(
              //           width: width * .3,
              //           height: width * .3,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: AssetImage('assets/images/book.png'),
              //             ),
              //           ),
              //           child: Image.asset('assets/images/book.png'),
              //         ),
              //         Container(
              //           width: width * .4,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "O'tkan kunlar",
              //                 style: TextStyle(
              //                   fontSize: 23,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //               Text(
              //                 "O'tkir Hoshimov",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontSize: 15,
              //                   color: grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IconButton(
              //             onPressed: () {},
              //             icon: Icon(CupertinoIcons.arrowshape_turn_up_right)),
              //         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenAddressBar extends StatelessWidget {
  const HomeScreenAddressBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .09,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: addressBarGradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .02),
            height: height * .1,
            width: width * .28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(
                colors: addressBarGradientColorFav,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: white,
                  size: 30,
                ),
                Text(
                  'Favorites',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .02),
            height: height * .1,
            width: width * .28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(
                colors: addressBarGradientColorPlay,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.playlist_add_check,
                  color: white,
                  size: 30,
                ),
                Text(
                  'Playlists',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .02),
            height: height * .1,
            width: width * .28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(
                colors: addressBarGradientColorRec,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.watch_later,
                  color: white,
                  size: 30,
                ),
                Text(
                  'Recent',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
