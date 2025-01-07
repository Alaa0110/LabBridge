// lib/screens/add_product_screen.dart






/*class AddProductScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();
                if (name.isNotEmpty) {
                  adminController.addProduct(name);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Please enter a product name');
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}*/
