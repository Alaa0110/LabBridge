
/*class DoctorRegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Extract companyCode and companyName from the arguments
    final Map<String, dynamic>? arguments = Get.arguments;
    final String? companyCode = arguments?['companyCode'];

    // Pre-fill the companyCode if available
    if (companyCode != null) {
      companyCodeController.text = companyCode;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'سجل ك طبيب',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTextField(
                    controller: companyCodeController,
                    label: 'رمز المعمل',
                    icon: Icons.business,
                  ),
                  _buildTextField(
                    controller: clinicNameController,
                    label: 'اسم العيادة',
                    icon: Icons.local_hospital,
                  ),
                  _buildTextField(
                    controller: firstNameController,
                    label: 'الاسم الاول',
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    controller: lastNameController,
                    label: 'الاسم الاخير',
                    icon: Icons.person_outline,
                  ),
                  _buildTextField(
                    controller: emailController,
                    label: 'الإيميل',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    controller: passwordController,
                    label: 'كلمة المرور',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  _buildTextField(
                    controller: confirmedPasswordController,
                    label: 'تأكيد كلمة المرور',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return authController.isLoading.value
                        ? CircularProgressIndicator()
                        : GestureDetector(
                      onTap: () {
                        authController.registerDoctor(
                          companyCodeController.text,
                          clinicNameController.text,
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text,
                          confirmedPasswordController.text,
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Color(0xff174ab8),
                            Color(0xff151d37),
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
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
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff1732b8),
          ),
        ),
        keyboardType: inputType,
        obscureText: obscureText,
      ),
    );
  }
}*/
