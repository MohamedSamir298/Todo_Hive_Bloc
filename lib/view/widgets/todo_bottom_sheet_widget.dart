import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/keys.dart';

class TodoBottomSheet extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final TextEditingController timeController;

  TodoBottomSheet({
    required this.titleController,
    required this.descriptionController,
    required this.dateController,
    required this.timeController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextField(
                controller: titleController,
                label: "Title",
                icon: Icons.title,
                validator: (value) => value!.isEmpty ? "Title can't be empty!" : null,
              ),
              buildTextField(
                controller: descriptionController,
                label: "Description",
                icon: Icons.description,
                validator: (value) => value!.isEmpty ? "Description can't be empty!" : null,
              ),
              buildDateField(context),
              buildTimeField(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white12),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Padding buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: dateController,
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2029, 1, 1),
          ).then((pickedDate) {
            if (pickedDate != null) {
              dateController.text = DateFormat.yMMMd().format(pickedDate);
            }
          });
        },
        validator: (value) => value!.isEmpty ? "Date can't be empty!" : null,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.date_range, color: Colors.white12),
          labelText: "Date",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Padding buildTimeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: timeController,
        readOnly: true,
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((pickedTime) {
            if (pickedTime != null) {
              timeController.text = pickedTime.format(context);
            }
          });
        },
        validator: (value) => value!.isEmpty ? "Time can't be empty!" : null,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.access_time, color: Colors.white12),
          labelText: "Time",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
