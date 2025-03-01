import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoassessment/model/todo_model.dart';
import 'package:todoassessment/src/view/todo_module/provider/todo_provider.dart';

class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo'),
        ),
        body: Consumer<TodoProvider>(builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: value.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: value.setActivityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter activity';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Activity',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: value.setPriceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  DropdownButtonFormField(
                    items: value.setTodoType.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select type';
                      }
                      return null;
                    },
                    onChanged: (values) {
                      value.setTypeValue = values.toString();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Type',
                    ),
                  ),
                  CheckboxListTile(
                    value: value.setBookingRequired,
                    onChanged: (values) {
                      value.setBookingRequiredValue(values!);
                    },
                    title: const Text('Booking required'),
                  ),
                  const Text('Accessibility:'),
                  Slider(
                    value: value.setAccessbility,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: value.setAccessbility.toString(),
                    onChanged: (newValue) {
                      value.setAccessbilityValue(newValue);
                    },
                  ),
                  Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple),
                        onPressed: value.getTodoLoading
                            ? null
                            : () async {
                                if (value.formKey.currentState!.validate()) {
                                  await value.addTodoList(TodoModel(
                                      activity:
                                          value.setActivityController.text,
                                      price: value.setPriceController.text,
                                      type: value.setTypeValue,
                                      bookingRequired: value.setBookingRequired,
                                      accessibility: value.setAccessbility));
                                  value.setActivityController.clear();
                                  value.setPriceController.clear();
                                  value.setAccessbility = 0.0;
                                  value.setBookingRequired = false;
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                        child: value.getTodoLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Submit todo',
                                style: TextStyle(color: Colors.white),
                              )),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
