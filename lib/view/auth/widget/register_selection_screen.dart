// lib/view/register_selection_page.dart

/*class RegisterSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the companyName from the arguments passed by Get.toNamed
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    final String companyName = arguments['companyName'] ?? 'Unknown Lab';

    return DefaultTabController(
      length: 2,  // Number of tabs
      child: Scaffold(
        body: Stack(
          children: [
            // Background gradient and heading text
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff174ab8),
                    Color(0xff151d37),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'سجل حسابك\nلدى معمل $companyName', // Display company name here
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // White container with rounded corners
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    // TabBar for Doctor and Technical tabs
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color(0xffB81736),
                      tabs: [
                        Tab(text: "طبيب"),
                        Tab(text: "فني"),
                      ],
                    ),
                    // Expanded TabBarView to hold the tab content
                    Expanded(
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          DoctorRegisterScreen(), // First tab content
                          TechnicalRegisterScreen(), // Second tab content
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


