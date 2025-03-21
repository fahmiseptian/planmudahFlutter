import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Cardproject extends StatelessWidget {
  final String endDate;
  final String startDate;
  final int totalTask;
  final int complateTask;

  const Cardproject({
    super.key,
    required this.endDate,
    required this.startDate,
    required this.totalTask,
    required this.complateTask,
  });

  @override
  Widget build(BuildContext context) {
    int pendingTasks = totalTask - complateTask;
    int presentaseTask =
        totalTask == 0 ? 0 : ((complateTask / totalTask) * 100).round();

    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name Project",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Start Date",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          startDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          "End Date",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          endDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              sectionsSpace: 0,
                              centerSpaceRadius: 20,
                              titleSunbeamLayout: false,
                              sections: [
                                // Pending
                                PieChartSectionData(
                                  value: pendingTasks.toDouble(),
                                  showTitle: false,
                                  color: Colors.black38,
                                  radius: 15,
                                  titleStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Complete
                                PieChartSectionData(
                                  value: 2.toDouble(),
                                  showTitle: false,
                                  color:
                                      presentaseTask < 60
                                          ? Colors.red
                                          : presentaseTask <= 80
                                          ? Colors.orange
                                          : Colors.lightGreen,
                                  radius: 15,
                                  titleStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              "$presentaseTask%",
                              style: TextStyle(
                                color:
                                    presentaseTask < 60
                                        ? Colors.red
                                        : presentaseTask <= 80
                                        ? Colors.orange
                                        : Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(color: Colors.grey, width: 1.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "See Detail",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
