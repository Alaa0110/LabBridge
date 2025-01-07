

/*class TechnicalRegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? companyCode = Get.arguments;
    if (companyCode != null) {
      companyCodeController.text = companyCode; // تعبئة الحقل
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Technical Registration',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: companyCodeController,
                        label: 'Company Code',
                        icon: Icons.business,
                      ),
                      _buildTextField(
                        controller: firstNameController,
                        label: 'First Name',
                        icon: Icons.person,
                      ),
                      _buildTextField(
                        controller: lastNameController,
                        label: 'Last Name',
                        icon: Icons.person_outline,
                      ),
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                      ),
                      _buildTextField(
                        controller: passwordController,
                        label: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                      _buildTextField(
                        controller: confirmedPasswordController,
                        label: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            authController.registerTechnical(
                              companyCodeController.text,
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              passwordController.text,
                              confirmedPasswordController.text,
                            );
                          },
                          child: const Text(
                            'Register Technical',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(),
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.teal.withOpacity(0.05),
        ),
        keyboardType: inputType,
        obscureText: obscureText,
      ),
    );
  }
}*/
