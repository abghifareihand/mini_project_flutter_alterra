import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project_flutter_alterra/pages/setting/setting_page.dart';
void main() {
  group('Widget Page Test', () {
    testWidgets('terdapat text my account', (tester) async {
      // Me-render widget
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final text = find.text("My Account");
      expect(text, findsOneWidget);
    });
    testWidgets('terdapat text notifications', (tester) async {
      // Me-render widget
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final text = find.text("Notifications");
      expect(text, findsOneWidget);
    });
    testWidgets('terdapat text help center', (tester) async {
      // Me-render widget
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final text = find.text("Help Center");
      expect(text, findsOneWidget);
    });
    testWidgets('terdapat text logout', (tester) async {
      // Me-render widget
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final text = find.text("Logout");
      expect(text, findsOneWidget);
    });

    testWidgets('terdapat 4 icon arrow forward', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final icon = find.byIcon(Icons.arrow_forward_ios);
      expect(icon, findsNWidgets(4));
    });

    testWidgets('terdapat gambar circle', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final image = find.byType(CircleAvatar);
      expect(image, findsOneWidget);
    });

    testWidgets('tidak terdapat icon delete', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingPage()));
      final icon = find.byIcon(Icons.delete);
      expect(icon, findsNothing);
    });
  });
}
