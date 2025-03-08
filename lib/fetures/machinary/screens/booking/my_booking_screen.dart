import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/booking_provider.dart';
import '../../models/booking_model.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  Future<void>? _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _bookingsFuture = Future.delayed(Duration.zero).then((_) {
      // if (!mounted) return;
      return context.read<BookingProvider>().fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                //TODO : featch bookings
                // _bookingsFuture = context.read<BookingProvider>().fetchBookings();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer<BookingProvider>(
            builder: (context, bookingProvider, child) {
              if (bookingProvider.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${bookingProvider.error}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          bookingProvider.clearError();
                          setState(() {
                            //TODO : featch bookings
                            // _bookingsFuture = bookingProvider.fetchBookings();
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (bookingProvider.bookings.isEmpty) {
                return const Center(
                  child: Text('No bookings found'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bookingProvider.bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookingProvider.bookings[index];
                  return BookingCard(booking: booking);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.machinery['name'] ?? 'Unknown Machinery',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Status: ${booking.status}'),
            Text('Start Date: ${booking.startDate.toString().split(' ')[0]}'),
            Text('End Date: ${booking.endDate.toString().split(' ')[0]}'),
            if (booking.totalAmount != null)
              Text('Total Amount: ₹${booking.totalAmount}'),
            if (booking.withOperator) const Text('With Operator: Yes'),
            if (booking.location != null && booking.location?['address'] != null)
              Text('Location: ${booking.location ?['address']}'),
            if (booking.notes?.isNotEmpty ?? false)
              Text('Notes: ${booking.notes}'),
          ],
        ),
      ),
    );
  }
}
