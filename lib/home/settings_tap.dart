import 'package:flutter/material.dart';
import 'package:todo_app/theme/my_theme.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Language',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MyTheme.blackColor,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'English',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 20,
                      ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_drop_down_outlined))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            'Mode',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MyTheme.blackColor,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Light',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 20,
                      ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_drop_down_outlined))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
