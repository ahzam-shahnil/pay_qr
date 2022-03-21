import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';

import 'add_customer.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List<Contact> _contacts = [];
  List<Contact> _contactsFiltered = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    getContacts();
    searchController.addListener(_filterContacts);
  }

  Future<void> getContacts() async {
    final List<Contact> contacts = await ContactsService.getContacts(
      withThumbnails: false,
      photoHighResolution: false,
    );
    setState(() {
      _contacts = contacts;
    });
  }

  void _filterContacts() {
    List<Contact> _results = [];
    _results.addAll(_contacts);
    if (searchController.text.trim().isNotEmpty) {
      isSearching = true;
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();

        String contactName = contact.displayName!.toLowerCase();

        return contactName.contains(searchTerm);
      });
      setState(() {
        _contactsFiltered = _contacts;
      });
    } else {
      setState(() {
        isSearching = false;
      });
      getContacts();
    }
    // logger.d(isSearching);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kScanBackColor,
        appBar: AppBar(
          title: (const Text('Contacts')),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(
                      Icons.close,
                    ),
                    hintText: 'Search Customer',
                  ),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const AddCustomer());
                  },
                  child: const Text(
                    "  + Add new Customer",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      isSearching ? _contactsFiltered.length : _contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact? contact = isSearching
                        ? _contactsFiltered[index]
                        : _contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: Text(
                          contact.initials(),
                          style: Get.textTheme.headline6,
                        ),
                      ),
                      title: Text(contact.displayName ?? ''),
                      onTap: () {
                        Get.to(() => AddCustomer(
                              contact: contact,
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
