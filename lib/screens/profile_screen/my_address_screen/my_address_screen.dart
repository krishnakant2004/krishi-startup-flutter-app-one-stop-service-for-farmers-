import 'package:gap/gap.dart';
import 'package:krishidost/utility/extensions.dart';

import '../../../utility/app_data.dart';
import '../../../widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.profileProvider.retrieveSavedAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Address",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppData.darkOrange),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: context.profileProvider.addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            labelText: 'Phone',
                            onSave: (value) {},
                            inputType: TextInputType.number,
                            controller: context.profileProvider.phoneController,
                            validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                          ),
                          const Gap(8),
                          CustomTextField(
                            labelText: 'Street',
                            onSave: (val) {},
                            controller: context.profileProvider.streetController,
                            validator: (value) => value!.isEmpty ? 'Please enter a street' : null,
                          ),
                          const Gap(8),
                          CustomTextField(
                            labelText: 'City',
                            onSave: (value) {},
                            controller: context.profileProvider.cityController,
                            validator: (value) => value!.isEmpty ? 'Please enter a city' : null,
                          ),
                          const Gap(8),
                          CustomTextField(
                            labelText: 'State',
                            onSave: (value) {},
                            controller: context.profileProvider.stateController,
                            validator: (value) => value!.isEmpty ? 'Please enter a state' : null,
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'Postal Code',
                                  onSave: (value) {},
                                  inputType: TextInputType.number,
                                  controller: context.profileProvider.postalCodeController,
                                  validator: (value) => value!.isEmpty ? 'Please enter a code' : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'Country',
                                  onSave: (value) {},
                                  controller: context.profileProvider.countryController,
                                  validator: (value) => value!.isEmpty ? 'Please enter a country' : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppData.darkOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        if (context.profileProvider.addressFormKey.currentState!.validate()) {
                          context.profileProvider.storeAddress();
                        }
                      },
                      child: const Text('Update Address', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
