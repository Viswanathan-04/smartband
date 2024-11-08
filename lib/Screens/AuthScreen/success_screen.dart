import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartband/Providers/SubscriptionData.dart';
import 'package:smartband/Screens/AuthScreen/signup.dart';
import 'package:smartband/Screens/Dashboard/supervisor_dashboard.dart';
import 'package:smartband/Screens/HomeScreen/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

class RoleSelectionScreen extends StatefulWidget {
  final String role;
  final String phNo;
  final String deviceId;
  final String status;

  RoleSelectionScreen({
    required this.role,
    required this.phNo,
    required this.deviceId,
    required this.status,
  });

  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final subscriptionStatus = Provider.of<SubscriptionDataProvider>(context);
    print(widget.role);
    if (!subscriptionStatus.isSubscribed &&
        !_dialogShown &&
        widget.role == 'watch wearer') {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.close),
                  //     onPressed: () {
                  //       Navigator.of(context).pop(); // Close the dialog
                  //     },
                  //   ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Make Sure Your Subscription',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Take the first step towards a healthier and happier life',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        const url = 'https://longlife.lk/subscription/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text(
                        'Subscribe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        const url = 'https://longlife.lk/contact-us/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text(
                        'Need Support?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final person =
        widget.role == 'supervisor' ? 'Monitoring Person' : 'Device Owner';
    final subscriptionStatus = Provider.of<SubscriptionDataProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.role == 'supervisor'
                  ? 'assets/image231.png'
                  : 'assets/image230.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: screenHeight * 0.03,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                person,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.4,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: screenWidth * 0.3,
                ),
                const SizedBox(height: 10),
                Text(
                  'Logged in successfully\nas a $person',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: screenHeight * 0.3),
                if (widget.role == 'supervisor' || subscriptionStatus.isActive)
                  ElevatedButton(
                    onPressed: () {
                      if (widget.status == '1') {
                        if (widget.role == 'supervisor') {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  maintainState: true,
                                  builder: (context) => SupervisorDashboard(
                                        phNo: widget.phNo,
                                      )));
                        } else {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  maintainState: true,
                                  builder: (context) => const HomepageScreen(
                                        hasDeviceId: true,
                                      )));
                        }
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupScreen(
                                  phNo: widget.phNo,
                                  role: widget.role,
                                  deviceId: widget.deviceId,
                                )));
                      }
                    },
                    child: const Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenHeight * 0.15,
                          vertical: screenWidth * 0.03),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
