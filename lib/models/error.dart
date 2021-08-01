

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class Error {
  String message;
  IconData icon;

  Error({required this.message, this.icon = Icons.warning});
  factory Error.mapErrorMessageToLabel(String message){
      if(message.contains("SocketException")){
        return Error(
          message: "network_error"
        );
      } else if (message.contains("TimeoutException")){
        return Error(
          message: "network_timeout"
        );
      } else if (message.contains("Unauthorized")) {
        return Error(
          message: "unauthorized_access"
        );
      } else {
        return Error(
          message: "server_error"
        );
      }

  }
}
