

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PaginationBar extends StatelessWidget {
  final int loadingPage;
  final int totalPages;

  PaginationBar({required this.loadingPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      height: MediaQuery.of(context).size.height * 0.09,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 15,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2.5,
                ),
              ),
              SizedBox(width: 15,),
              Text("loading_page".trParams({
                "loadPage" : "$loadingPage",
                "totalPage" : "$totalPages"
              }) ?? "Loading page $loadingPage of $totalPages"),
              Spacer(),
            ],
          ),
        )
      ),
    );
  }
}
