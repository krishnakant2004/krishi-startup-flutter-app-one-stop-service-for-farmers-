import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../widget/apply_coupon_button.dart';
import '../../../../widget/complete_order_button.dart';
import '../../../../widget/custom_drop_down.dart';
import '../../../../widget/custom_text_field.dart';
import '../provider/cart_provider.dart';

void showCustomBottomSheet(BuildContext context) {
  context.cartProvider.clearCouponDiscount();
  context.cartProvider.retrieveSavedAddress();
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(24)), // Rounded top corners
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: context.cartProvider.buyNowFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),

                // Address Section
                ListTile(
                  title: const Text(
                    'Enter Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      context.cartProvider.isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      size: 28,
                    ),
                    onPressed: () {
                      context.cartProvider.isExpanded =
                          !context.cartProvider.isExpanded;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),

                // Address Fields
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Visibility(
                        visible: cartProvider.isExpanded,
                        child: Column(
                          children: [
                            CustomTextField(
                              height: 55,
                              labelText: 'Phone',
                              onSave: (value) {},
                              inputType: TextInputType.number,
                              controller: context.cartProvider.phoneController,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a phone number'
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 55,
                              labelText: 'Street',
                              onSave: (val) {},
                              controller: context.cartProvider.streetController,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a street'
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 55,
                              labelText: 'City',
                              onSave: (value) {},
                              controller: context.cartProvider.cityController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter a city' : null,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 55,
                              labelText: 'State',
                              onSave: (value) {},
                              controller: context.cartProvider.stateController,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a state'
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    height: 55,
                                    labelText: 'Postal Code',
                                    onSave: (value) {},
                                    inputType: TextInputType.number,
                                    controller: context
                                        .cartProvider.postalCodeController,
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter a code'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomTextField(
                                    height: 55,
                                    labelText: 'Country',
                                    onSave: (value) {},
                                    controller:
                                        context.cartProvider.countryController,
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter a country'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Payment Options
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CustomDropdown<String>(
                      bgColor: Colors.white,
                      hintText: cartProvider.selectedPaymentOption,
                      items: const ['cod', 'prepaid'],
                      onChanged: (val) {
                        cartProvider.selectedPaymentOption = val ?? 'prepaid';
                        cartProvider.updateUI();
                      },
                      displayItem: (val) => val,
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Coupon Code Field
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        height: 60,
                        labelText: 'Enter Coupon code',
                        onSave: (value) {},
                        controller: context.cartProvider.couponController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ApplyCouponButton(
                      onPressed: () {
                        context.cartProvider.checkCoupon();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Total Amount Section
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount               : ₹${context.cartProvider.getCartSubTotal()}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Offer Applied   : ₹${cartProvider.couponCodeDiscount}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Grand Total              : ₹${context.cartProvider.getGrandTotal()}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Complete Order Button
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CompleteOrderButton(
                      labelText:
                          'Complete Order  ₹${context.cartProvider.getGrandTotal()}',
                      onPressed: () {
                        if (!cartProvider.isExpanded) {
                          cartProvider.isExpanded = true;
                          cartProvider.updateUI();
                          return;
                        }
                        // Check if the form is valid
                        if (context.cartProvider.buyNowFormKey.currentState!
                            .validate()) {
                          context.cartProvider.buyNowFormKey.currentState!
                              .save();
                          context.cartProvider.submitOrder(context);
                          return;
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
