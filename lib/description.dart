import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_list/custom_text.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
  }) : super(key: key);

  final String posterPath, title, overview, backdropPath, releaseDate;
  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: ListView(children: [
        SizedBox(
          height: 250,
          child: Stack(children: [
            Positioned(
              child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(backdropPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5.0, sigmaX: 5.0),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(35),
                              border:
                                  Border.all(width: 2, color: Colors.white30)),
                          child: FittedBox(
                              child: CustomText(
                            text: title,
                            fontSize: 35,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                  )),
            ),
          ]),
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const CustomText(
                text: 'Realised: ',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            CustomText(
              text: releaseDate,
              color: Colors.grey,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(posterPath)),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(width: 2, color: Colors.white30),
                      ),
                      child: CustomText(
                        text: '$voteAverage',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: CustomText(
                          text: overview,
                          maxLines: 10,
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
