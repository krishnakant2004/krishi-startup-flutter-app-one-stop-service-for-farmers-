import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/machinary_provider.dart';

class AddMachineryScreen extends StatefulWidget {
  const AddMachineryScreen({super.key});

  @override
  State<AddMachineryScreen> createState() => _AddMachineryScreenState();
}

class _AddMachineryScreenState extends State<AddMachineryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _dailyRateController = TextEditingController();
  final _operatorChargesController = TextEditingController();
  final _categoryController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedType = 'Tractor';
  bool _operatorAvailable = false;
  bool _isLoading = false;
  final Map<String, TextEditingController> _specControllers = {};

  final List<String> _machineryTypes = [
    'Tractor',
    'Harvester',
    'Cultivator',
    'Thresher',
    'Sprayer',
    'Water Pump',
  ];

  final List<String> _defaultSpecs = [
    'Brand',
    'Model',
    'Power',
    'Year',
    'Condition',
  ];

  @override
  void initState() {
    super.initState();
    for (var spec in _defaultSpecs) {
      _specControllers[spec] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _hourlyRateController.dispose();
    _dailyRateController.dispose();
    _operatorChargesController.dispose();
    _categoryController.dispose();
    _locationController.dispose();
    for (var controller in _specControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (!context.read<AuthProvider>().isAuthenticated) {
        throw 'Please login to add machinery';
      }

      final specifications = <String, String>{};
      for (var entry in _specControllers.entries) {
        if (entry.value.text.isNotEmpty) {
          specifications[entry.key] = entry.value.text;
        }
      }

      final machineryData = {
        'name': _nameController.text,
        'type': _selectedType,
        'description': _descriptionController.text,
        'hourlyRate': double.parse(_hourlyRateController.text),
        'dailyRate': double.parse(_dailyRateController.text),
        'operatorAvailable': _operatorAvailable,
        'operatorCharges': _operatorAvailable
            ? double.parse(_operatorChargesController.text)
            : 0,
        'specifications': specifications,
        'images': [], // TODO: Add image upload functionality
        'location': {
          'type': 'Point',
          'coordinates': [0, 0], // TODO: Add location picker
        },
      };

      await context.read<MachineryProvider>().createMachinery(machineryData);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Machinery added successfully')),
      );

      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Machinery'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter machinery name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: _machineryTypes
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hourlyRateController,
                      decoration: const InputDecoration(
                        labelText: 'Hourly Rate (₹)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter hourly rate';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _dailyRateController,
                      decoration: const InputDecoration(
                        labelText: 'Daily Rate (₹)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter daily rate';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Operator Available'),
                value: _operatorAvailable,
                onChanged: (value) {
                  setState(() {
                    _operatorAvailable = value;
                  });
                },
              ),
              if (_operatorAvailable) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _operatorChargesController,
                  decoration: const InputDecoration(
                    labelText: 'Operator Charges (₹/day)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter operator charges';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                'Specifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._defaultSpecs.map(
                    (spec) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _specControllers[spec],
                    decoration: InputDecoration(
                      labelText: spec,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Add Machinery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
