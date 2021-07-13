import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/controllers/tetris_controller.dart';

class NextBlock extends StatefulWidget {
  const NextBlock({Key? key}) : super(key: key);

  @override
  _NextBlockState createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  TetrisController tetrisController = Get.put(TetrisController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Next',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.indigo[600],
              child: Center(
                child: tetrisController.getNextBlockWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
