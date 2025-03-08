import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../widget/custom_alert_dialog.dart';
import '../../location_service.dart';
import '../../models/machinary_model.dart';
import '../../providers/booking_provider.dart';

// krishna9669kantdinkar@gmail.com
// Krishna9669@

class CreateBookingScreen extends StatefulWidget {
  final Machinery machinery;

  const CreateBookingScreen({
    super.key,
    required this.machinery,
  });

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _withOperator = false;
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final _locationCoordinatesController = TextEditingController();
  bool _isLoading = false;
  List<double> locationPoints = [0,0];

  double? _totalAmount;

  void _calculateTotalAmount() {
    if (_startDate != null && _endDate != null) {
      final days = _endDate!.difference(_startDate!).inDays + 1;
      double total = days * widget.machinery.dailyRate;
      if (_withOperator && widget.machinery.operatorAvailable) {
        total += days * widget.machinery.operatorCharges;
      }
      setState(() {
        _totalAmount = total;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
          _startDate ??= picked;
        }
        _calculateTotalAmount();
      });
    }
  }

  Future<void> _submit() async {
    if(kDebugMode){
      print('machinary id: ${widget.machinery.id}');
    }
    if (!_formKey.currentState!.validate() ||
        _startDate == null ||
        _endDate == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<BookingProvider>(context, listen: false).createBooking({
        'machinery': widget.machinery.id.toString(),
        'startDate': _startDate!.toIso8601String(),
        'endDate': _endDate!.toIso8601String(),
        'withOperator': _withOperator,
        'location': {
          'address': _locationController.text,
          'coordinates': locationPoints, // Ensure this contains actual [longitude, latitude]
        },
        'notes': _notesController.text,
      });

      if (mounted) { // Ensure widget is mounted before calling context-dependent code
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking created successfully')),
        );
      }

    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      await customeAlertDialog(
        context: context,
        title: 'Error',
        content: "Failed to create booking",
        isSuccess: false,
      );
    }

    if (mounted) { //  Ensure widget is still active
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _getLocation() async {
    print("hello");
    LocationService locationService = LocationService();


    //coordinate in array which contain longitude,latitude
    final coordinates = await locationService.getUserLocation();
    print("$coordinates");
    if(coordinates != null){
      _locationCoordinatesController.text = "$coordinates";
      locationPoints = coordinates;
      return;
    }
    customeAlertDialog(context: context, title: 'Location Denied ❌', content: "unable to get Location");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: ListTile(
                  title: Text(widget.machinery.name),
                  subtitle: Text(widget.machinery.type),
                  leading: widget.machinery.images.isNotEmpty
                      ? CircleAvatar(
                    backgroundImage:
                    NetworkImage(widget.machinery.images[0]),
                  )
                      : const CircleAvatar(
                    child: Icon(Icons.agriculture),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Dates',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _selectDate(context, true),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _startDate == null
                            ? 'Start Date'
                            : DateFormat('MMM dd, yyyy').format(_startDate!),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _selectDate(context, false),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _endDate == null
                            ? 'End Date'
                            : DateFormat('MMM dd, yyyy').format(_endDate!),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.machinery.operatorAvailable) ...[
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Include Operator'),
                  subtitle: Text(
                      'Additional ₹${widget.machinery.operatorCharges}/day'),
                  value: _withOperator,
                  onChanged: (value) {
                    setState(() {
                      _withOperator = value;
                      _calculateTotalAmount();
                    });
                  },
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Delivery Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the delivery location';
                        }
                        return null;
                      },
                    ),),
                  SizedBox(width: 8,),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _locationCoordinatesController,
                      decoration: InputDecoration(
                        labelText: "Enter coordinates",
                        border: OutlineInputBorder(),
                        suffixIcon:SizedBox(
                          width: 100,
                          height: 30,
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton.icon(
                              onPressed: () { _getLocation();},
                              label: Text(
                                "get Location",
                                style: TextStyle(fontSize: 12), // Decrease text size
                              ),
                              icon: Icon(
                                Icons.location_on_rounded,
                                color: Colors.green,
                                size: 16, // Decrease icon size
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduce padding
                                backgroundColor: Colors.green.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)), // Adjust border radius
                                ),
                                minimumSize: Size(100, 30), // Set fixed width & height
                              ),
                            ),
                          ),
                        ),

                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              if (_totalAmount != null) ...[
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Amount',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹$_totalAmount',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Confirm Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
