import 'package:about/about.dart' as about;
import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pubspec.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return about.AboutPage(
      values: {
        'version': Pubspec.version,
        'buildNumber': Pubspec.versionBuild.toString(),
        'year': '2023-2024',
        'author': Pubspec.authorsname,
      },
      title: Text(S.of(context).about),
      applicationVersion:
          S.of(context).versionBuild('{version}', '{buildNumber}'),
      applicationDescription: Text(
        S.of(context).labelAppDescription,
        textAlign: TextAlign.justify,
      ),
      applicationIcon: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          'assets/images/app_logo.png',
          width: 96,
          height: 96,
          fit: BoxFit.contain,
        ),
      ),
      applicationLegalese: S.of(context).authorYear('{author}', '{year}'),
      children: <Widget>[
        MarkdownPageListTile(
          filename: 'README.md',
          title: Text(S.of(context).viewReadme),
          icon: const Icon(Icons.description),
        ),
        MarkdownPageListTile(
          filename: 'CHANGELOG.md',
          title: Text(S.of(context).viewChangelog),
          icon: const Icon(Icons.tips_and_updates),
        ),
        MarkdownPageListTile(
          filename: 'PRIVACY-POLICY.md',
          title: Text(S.of(context).viewPrivacyPolicy),
          icon: const Icon(Icons.privacy_tip),
        ),
      ],
    );
  }
}
