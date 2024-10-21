import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/NewsChannelheadline.dart';
import 'package:newsapp/view_models/new_view_model.dart';

import 'catergoryview.dart';
import 'models/cetagories.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

enum filterlist { bbcnews, arynews, abcnews, reuter, cnn, aljera }

class _ViewScreenState extends State<ViewScreen> {
  filterlist? selectmenu;
  NewViewModel newViewModel = NewViewModel();
  final format = DateFormat('MM dd yyyy');

  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => categoryscreen()));
          },
          icon: Image.asset('images/category_icon.png'),
        ),
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          PopupMenuButton<filterlist>(
              initialValue: selectmenu,
              onSelected: (filterlist item) {
                if (filterlist.bbcnews.name == item.name) {
                  name = 'bbc-news';
                }
                if (filterlist.arynews.name == item.name) {
                  name = 'ary-news';
                }
                if (filterlist.abcnews.name == item.name) {
                  name = 'abc-news';
                }
                if (filterlist.aljera.name == item.name) {
                  name = 'al-jazeera-english';
                }

                CachedNetworkImage.evictFromCache(name);
                setState(() {});
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<filterlist>>[
                    PopupMenuItem<filterlist>(
                      value: filterlist.bbcnews,
                      child: Text('bbc news'),
                    ),
                    PopupMenuItem<filterlist>(
                      value: filterlist.arynews,
                      child: Text('arya news'),
                    ),
                    PopupMenuItem<filterlist>(
                      value: filterlist.abcnews,
                      child: Text('abc news'),
                    ),
                    PopupMenuItem<filterlist>(
                      value: filterlist.aljera,
                      child: Text('aljera news'),
                    )
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelheadline>(
                future: newViewModel.fetchchannelheadline(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCubeGrid(
                        size: 40,
                        color: Colors.redAccent,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime datetime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 1,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * .02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      useOldImageOnUrlChange:
                                          false, // Prevents keeping the old image
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(child: spinkit),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height * .22,
                                      width: width * .9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * .6,
                                            child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * .9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(format.format(datetime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
          FutureBuilder<Cetagories>(
              future: newViewModel.fetcetagories('general'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime datetime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());

                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(11),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  placeholder: (context, url) =>
                                      Container(child: spinkit),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              height: height * .18,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].source
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        format.format(datetime),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        );
                      });
                }
              }),
        ],
      ),
    );
  }
}

const spinkit = SpinKitFadingCircle(
  color: Colors.grey,
  size: 50,
);

// CachedNetworkImage(
// imageUrl: snapshot
//     .data!.articles![index].urlToImage
//     .toString(),
// fit: BoxFit.cover,
// placeholder: (context, url) =>
// Container(child: spinkit),
// errorWidget: (context, url, error) =>
// Icon(
// Icons.error,
// color: Colors.red,
// ),
// ),
