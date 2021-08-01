import 'package:flutter/material.dart';

class CardMessage extends StatelessWidget {

  final Icon icon;
  final String message;
  final Function? onRetry;
  CardMessage({required this.icon, required this.message,  this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      width: MediaQuery.of(context).size.width * .90,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              icon,
              Text(message, textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              if(this.onRetry != null)
                TextButton.icon(
                    onPressed: () => this.onRetry!() ,
                    icon: Icon(Icons.refresh),
                    label: Text("RETRY")
                )
          ],
        ),
      ),
    );
  }
}
