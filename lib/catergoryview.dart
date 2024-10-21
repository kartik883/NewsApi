import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/cetagories.dart';
import 'package:newsapp/view.dart';
import 'package:newsapp/view_models/new_view_model.dart';

class categoryscreen extends StatefulWidget {
  const categoryscreen({super.key});

  @override
  State<categoryscreen> createState() => _categoryscreenState();
}

class _categoryscreenState extends State<categoryscreen> {
  NewViewModel newViewModel = NewViewModel();
  final format = DateFormat('MM dd yyyy');

  String catergoryname = 'General';
  List<String> allcatergory = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Checkbox.width * .1),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allcatergory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Checkbox.width),
                      child: InkWell(
                        onTap: () {
                          catergoryname = allcatergory[index];
                          setState(() {});
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .07),
                          decoration: BoxDecoration(
                            color: catergoryname == allcatergory[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              allcatergory[index].toString(),
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: FutureBuilder<Cetagories>(
                  future: newViewModel.fetcetagories(catergoryname),
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
                                      errorWidget: (context, url, error) =>
                                          Icon(
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
                                            snapshot
                                                .data!.articles![index].source
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
            ),
          ],
        ),
      ),
    );
  }
}
