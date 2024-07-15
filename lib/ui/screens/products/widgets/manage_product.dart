import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product.dart';
import '../../../../logic/cubits/product/product_cubit.dart';
import '../../../widgets/my_text_form_field.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({super.key, this.product});

  final Product? product;

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.product == null ? "" : titleController.text = widget.product!.title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? "Add product" : "Edit the product"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextFormField(
              label: widget.product == null
                  ? "Product title"
                  : "New product title",
              controller: titleController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return widget.product == null
                      ? "Enter product title"
                      : "Enter new product title";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.product == null
                ? context.read<ProductCubit>().addProduct(
                    id: UniqueKey().toString(),
                    title: titleController.text.trim(),
                    price: 100,
                    imageUrl:
                        "https://img.recraft.ai/7X2vwH8fjNyNYfcMLkFutQoU50UQxwxHJfOQxpNOJgg/rs:fit:1024:1024:0/q:80/g:no/plain/abs://prod/images/0bb94916-de52-4f04-b808-27d30cb9b896@avif")
                : context.read<ProductCubit>().editProduct(
                      id: widget.product!.id,
                      newTitle: titleController.text.trim(),
                      newImageUrl:
                          "https://img.recraft.ai/3ysBevlX6efTaHFkTRfYX_MnySbBwhG161FbiaqtEZg/rs:fit:1024:1024:0/q:80/g:no/plain/abs://prod/images/26b9707b-3a08-4a4c-8756-1fef9cd140f9@avif",
                    );
            Future.delayed(
                Duration.zero,
                widget.product == null
                    ? () {
                        Navigator.pop(context);
                      }
                    : () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
            titleController.clear();
          },
          child: Text(
            widget.product == null ? "Add" : "Save",
            style: const TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
