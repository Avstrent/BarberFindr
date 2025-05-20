import 'package:flutter/material.dart';

void main() {
  runApp(BarberFindrApp());
}

class BarberFindrApp extends StatelessWidget {
  // Custom color from hex #56B4B8
  final MaterialColor customTeal = createMaterialColor(Color(0xFF56B4B8));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarberFindr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customTeal,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF56B4B8),
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
      ),
      home: HomePage(customTeal),
    );
  }
}

// Helper function to create MaterialColor from Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class HomePage extends StatelessWidget {
  final MaterialColor primaryColor;
  HomePage(this.primaryColor);

  final List<Map<String, String>> barbers = [
    {'name': 'Fade Masters', 'location': 'Downtown', 'rating': '4.8'},
    {'name': 'Clean Cuts', 'location': 'Uptown', 'rating': '4.5'},
    {'name': 'Sharp Style', 'location': 'East Side', 'rating': '4.6'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BarberFindr')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.shade50,
              primaryColor.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: barbers.length,
          separatorBuilder: (_, __) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final barber = barbers[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: primaryColor.shade100,
                  child: Icon(Icons.storefront, color: primaryColor.shade700, size: 28),
                ),
                title: Text(
                  barber['name']!,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${barber['location']} • ⭐ ${barber['rating']}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[600]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BarberDetailsPage(barber: barber, primaryColor: primaryColor),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class BarberDetailsPage extends StatelessWidget {
  final Map<String, String> barber;
  final MaterialColor primaryColor;

  BarberDetailsPage({required this.barber, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(barber['name']!),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.storefront, size: 80, color: primaryColor.shade400),
            SizedBox(height: 24),
            Text(
              barber['name']!,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor.shade800),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, color: primaryColor.shade400),
                SizedBox(width: 6),
                Text(
                  barber['location']!,
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 6),
                Text(
                  barber['rating']!,
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'About',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: primaryColor.shade700),
            ),
            SizedBox(height: 8),
            Text(
              'This is a great place for quality haircuts. Book now to avoid the queue and enjoy excellent service with experienced barbers!',
              style: TextStyle(fontSize: 16, height: 1.4, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
