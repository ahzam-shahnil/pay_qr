import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';

import 'add_customer.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List<Contact?> _contacts = [];
  List<Contact?> _contactsFiltered = [];
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
    contacts.retainWhere((contact) {
      return contact.displayName == null
          ? false
          : contact.displayName!.isNotEmpty;
    });
    setState(() {
      _contacts = contacts;
    });
  }

  void _filterContacts() {
    List<Contact?> results = [];
    results.addAll(_contacts);
    if (searchController.text.trim().isNotEmpty) {
      isSearching = true;

      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();

        String contactName = contact == null
            ? ''
            : contact.displayName == null
                ? ''
                : contact.displayName!.toLowerCase();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kScanBackColor,
        appBar: AppBar(
          title: (Text(
            'Contacts',
            style: Get.textTheme.headline6,
          )),
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
                    Get.to(() =>  AddCustomerContact());
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
                    return contact == null
                        ? const SizedBox()
                        : ListTile(
                            leading: CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              child: Text(
                                contact.initials(),
                                style: Get.textTheme.headline6,
                              ),
                            ),
                            title: Text(contact.displayName ?? ''),
                            onTap: () {
                              if (contact.phones != null) {
                                Get.to(() => AddCustomerContact(
                                      displayName: contact.displayName ?? '',
                                      phoneNo: contact.phones!.isNotEmpty
                                          ? contact.phones!.first.value ?? ''
                                          : '',
                                    ));
                              }
                              logger.d(contact.displayName);
                              logger.d(contact.phones);
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
