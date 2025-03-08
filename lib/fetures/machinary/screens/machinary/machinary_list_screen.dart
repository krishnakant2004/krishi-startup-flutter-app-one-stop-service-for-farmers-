import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/machinary_model.dart';
import '../../providers/machinary_provider.dart';
import 'machinary_detail_screen.dart';

class MachineryListScreen extends StatelessWidget {
  const MachineryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MachineryProvider>(
      builder: (ctx, machineryProvider, child) {
        final machinery = machineryProvider.filteredMachinary;

        return RefreshIndicator(
          onRefresh: ()=> machineryProvider.fetchMachineryList(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search machinery...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          machineryProvider.searchMachinery(value);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: machinery.isEmpty
                    ? const Center(
                  child: Text('No machinery available'),
                )
                    : ListView.builder(
                  itemCount: machinery.length,
                  itemBuilder: (ctx, i) => MachineryListItem(
                    machinery: machinery[i],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Filter Machinery'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Type'),
              items: const [
                DropdownMenuItem(value: 'Tractor', child: Text('Tractor')),
                DropdownMenuItem(value: 'Harvester', child: Text('Harvester')),
                DropdownMenuItem(value: 'Cultivator', child: Text('Cultivator')),
                DropdownMenuItem(value: 'Thresher', child: Text('Thresher')),
                DropdownMenuItem(value: 'Sprayer', child: Text('Sprayer')),
                DropdownMenuItem(value: 'WaterPump', child: Text('Water Pump')),
              ],
              onChanged: (value) {
                // Handle filter change
              },
            ),
            CheckboxListTile(
              title: const Text('Available Only'),
              value: false,
              onChanged: (value) {
                // Handle availability filter
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Apply filters
              Navigator.of(ctx).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

class MachineryListItem extends StatelessWidget {
  final Machinery machinery;

  const MachineryListItem({
    super.key,
    required this.machinery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: machinery.images.isNotEmpty
            ? CircleAvatar(
          backgroundImage: NetworkImage(machinery.images[0]),
        )
            : const CircleAvatar(
          child: Icon(Icons.agriculture),
        ),
        title: Text(machinery.name),
        subtitle: Text(
          '${machinery.type} - ₹${machinery.dailyRate}/day',
        ),
        trailing: machinery.availability
            ? const Chip(
          label: Text('Available'),
          backgroundColor: Colors.green,
          labelStyle: TextStyle(color: Colors.white),
        )
            : const Chip(
          label: Text('Unavailable'),
          backgroundColor: Colors.red,
          labelStyle: TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MachineryDetailScreen(machinery: machinery),
            ),
          );
        },
      ),
    );
  }
}
