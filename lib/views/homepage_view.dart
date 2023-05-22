import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_module_info.dart';
import 'package:student_personal_assistant/components/custom_navbar.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/custom_icons_icons.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 91),
            CustomHeading(text: "Welcome,\nUsername"),
            SizedBox(height: 15),
            CustomText(
                text:
                    "Let's make your study sessions\nmore effective and efficient!",
                alignLeft: true),
            SizedBox(height: 20),
            CustomDivider(alignLeft: true),
            SizedBox(height: 48),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                CustomIcons.revise,
                color: Color(primaryColor),
              ),
              SizedBox(width: 8),
              CustomModuleInfo(
                  name: "Revise",
                  text:
                      "Review what you have studied\ntoday and set up your understanding\nlevel."),
            ]),
            SizedBox(height: 44),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CustomIcons.study,
                  color: Color(primaryColor),
                ),
                SizedBox(width: 8),
                CustomModuleInfo(
                    name: "Study",
                    text:
                        "Explore new subjects and\ntopics based on your areas of\nimprovement."),
              ],
            ),
            SizedBox(height: 44),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CustomIcons.quiz,
                  color: Color(primaryColor),
                ),
                SizedBox(width: 8),
                CustomModuleInfo(
                    name: "Quiz",
                    text:
                        "Quiz/Test: Get ready for upcoming\nquizzes or tests by focusing on\nrecommended topics."),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(selectedMenu: 0),
    );
  }
}
