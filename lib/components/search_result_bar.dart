

import 'package:flutter/material.dart';
import 'package:xfers_movie_assignment/constants/text_styles.dart';

class SearchResultBar extends StatelessWidget {
  final int totalResults;
  final int loadedResults;
  final String keyword;
  final Function? onClear;
  final bool isLoading;
  SearchResultBar({required this.keyword, required this.totalResults, required this.loadedResults, this.onClear, this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          elevation: 15,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                  Builder(
                    builder: (BuildContext context){
                      if(isLoading){
                        return SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            strokeWidth: 2.5,
                          ),
                        );
                      }
                      return SizedBox(
                        width: 20,
                      );
                    },
                  ),

                  Expanded(child: Wrap(
                    children: [
                      Text("Showing results of"),
                      Text("\"$keyword\"", overflow: TextOverflow.ellipsis,),
                      Text("Loaded $loadedResults of $totalResults"),

                    ],
                  )),
                  TextButton(
                      style: TextButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.black12
                      ),
                      onPressed: () => this.onClear != null ? this.onClear!() :  null,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("RESET", style: kTextButtonTextStyle,),
                      )
                  )
              ],
            )
          )
      ),
    );
  }
}
