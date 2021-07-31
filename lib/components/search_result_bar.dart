

import 'package:flutter/material.dart';

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
      height: MediaQuery.of(context).size.height * 0.11,
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          elevation: 15,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                if(isLoading)
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2.5,
                    ),
                  ),
                Expanded(child: Column(
                  children: [
                    Text("Showing results of \"$keyword\""),
                    Text("Loaded $loadedResults of $totalResults"),

                  ],
                ))
              ],
            )
          )
      ),
    );
  }
}
