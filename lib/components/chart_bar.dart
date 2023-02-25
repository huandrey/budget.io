import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? value;
  final double? percentage;

  const ChartBar({
    this.label,
    this.value,
    this.percentage,
    Key? key,
  }) : super(key: key);
  // (60 * porcentage / 100).toDouble()
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 62,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              child: FittedBox(
                child: Text(
                  'R\$ ${value?.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.red[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 10,
                height: 60,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                        // decoration: BoxDecoration(
                        //     // borderRadius: BorderRadius.circular(5.0),
                        //     border: Border.all(
                        //   color: Colors.grey,
                        //   width: 1,
                        // )),
                        ),
                    FractionallySizedBox(
                      heightFactor: percentage == 0 ? 0.02 : percentage,
                      child: Container(
                        decoration: BoxDecoration(
                            color: percentage == 0
                                ? Colors.grey[300]
                                : Colors.red[400]
                            // borderRadius: BorderRadius.circular(5.0)
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                label!,
                style: TextStyle(
                    color: Colors.green[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
