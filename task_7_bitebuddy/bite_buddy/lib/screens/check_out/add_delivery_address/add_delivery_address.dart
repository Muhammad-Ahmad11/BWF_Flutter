import 'package:flutter/material.dart';
import 'package:food_app/theme/colors.dart';
import 'package:food_app/viewmodels/providers/check_out_provider.dart';
import 'package:food_app/screens/check_out/google_map/google_map.dart';
import 'package:food_app/widgets/costom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({super.key});

  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: const Text(
                  "Add Address",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CostomTextField(
              labText: "First name",
              controller: checkoutProvider.firstName,
            ),
            CostomTextField(
              labText: "Last name",
              controller: checkoutProvider.lastName,
            ),
            CostomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo,
            ),
            CostomTextField(
              labText: "Alternate Mobile No",
              controller: checkoutProvider.alternateMobileNo,
            ),
            CostomTextField(
              labText: "Society",
              controller: checkoutProvider.scoiety,
            ),
            CostomTextField(
              labText: "Street",
              controller: checkoutProvider.street,
            ),
            CostomTextField(
              labText: "Landmark",
              controller: checkoutProvider.landmark,
            ),
            CostomTextField(
              labText: "City",
              controller: checkoutProvider.city,
            ),
            CostomTextField(
              labText: "Area",
              controller: checkoutProvider.aera,
            ),
            CostomTextField(
              labText: "Pincode",
              controller: checkoutProvider.pincode,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CostomGoogleMap(),
                  ),
                );
              },
              child: SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLoaction == null
                        ? const Text("Set Location")
                        : const Text("Done!"),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: const Text("Home"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: const Icon(
                Icons.home,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: const Text("Work"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: const Icon(
                Icons.work,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: const Text("Other"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: const Icon(
                Icons.devices_other,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
