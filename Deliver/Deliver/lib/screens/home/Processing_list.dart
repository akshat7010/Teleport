import 'package:flutter/material.dart';
import 'package:Deliver/models/order.dart';
import 'package:Deliver/screens/home/processing_tile.dart';
import 'package:Deliver/models/processing.dart';

class ProcessingList extends StatefulWidget {

  final List<dynamic> processing;
  final Function callBack;
  ProcessingList({this.processing,this.callBack});

  @override
  _ProcessingListState createState() => _ProcessingListState();
}

class _ProcessingListState extends State<ProcessingList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 5.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.processing.length,
          itemBuilder: (context, index){
            return ProcessingTile(processing: widget.processing[index],callBack: widget.callBack,);
          },
        ),
      ],
    );
  }
}
