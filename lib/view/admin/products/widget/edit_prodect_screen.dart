// lib/screens/edit_product_screen.dart




/*class EditProductScreen extends StatelessWidget {
  final Product product;
  final TextEditingController _nameController = TextEditingController();
  final adminController = Get.find<AdminController>();

  EditProductScreen({required this.product}) {
    _nameController.text = product.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newName = _nameController.text.trim();
                if (newName.isNotEmpty) {
                  adminController.editProduct(product.id, newName);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Please enter a product name');
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}*/
