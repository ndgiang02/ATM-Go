import 'package:atmgo/core/constants/constants.dart';
import 'package:atmgo/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width(5, context)),
        child: ListView(
          children: [
            SizedBox(height: Responsive.height(1.5, context)),
            Text(
              "dateString",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.fontSize(24, context),
              ),
            ),
            SizedBox(height: Responsive.height(3, context)),
            Text(
              'Finding ways',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.fontSize(18, context),
              ),
            ),
            SizedBox(height: Responsive.height(1.5, context)),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Responsive.width(4, context)),
                      margin: EdgeInsets.only(
                        right: Responsive.width(2, context),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(
                          Responsive.width(5, context),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            iconAtm,
                            height: Responsive.height(12, context),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: Responsive.height(1.2, context)),
                          Text(
                            'Find your bank',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.fontSize(
                                16,
                                context,
                              ), // Responsive font size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Responsive.width(4, context)),
                      margin: EdgeInsets.only(
                        left: Responsive.width(2, context),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(
                          Responsive.width(5, context),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            iconAtm,
                            height: Responsive.height(
                              12,
                              context,
                            ), // 12% of screen height
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: Responsive.height(1.2, context),
                          ), // 1.2% of screen height
                          Text(
                            'Find ATMs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.fontSize(
                                16,
                                context,
                              ), // Responsive font size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height(3, context),
            ), // 3% of screen height
            Text(
              'Near You',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.fontSize(18, context),
              ),
            ),
            SizedBox(height: Responsive.height(1.5, context)),
            const Center(child: Text('No banks found nearby')),
          ],
        ),
      ),
    );
  }
}
