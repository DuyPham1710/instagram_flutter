import 'package:flutter/material.dart';

class ModalMore extends StatelessWidget {
  const ModalMore({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        // height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    //   margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Icon(Icons.edit, color: Colors.black54),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 80,
                    // margin: EdgeInsets.only(
                    //   left: 8,
                    // ),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Icon(Icons.edit, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
