// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_contact.dart';
import 'contact_model.dart';
import 'contact_provider.dart'; // Import provider

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      home: ContactScreen(),
    );
  }
}

class ContactScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengakses daftar kontak dari provider
    final contacts = ref.watch(contactProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Hapus kontak melalui provider
                ref.read(contactProvider.notifier).removeContact(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigasi ke halaman tambah kontak dan terima data kembali
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(),
            ),
          );

          // Jika kontak baru ditambahkan, tambahkan ke daftar menggunakan provider
          if (result != null && result is Contact) {
            ref.read(contactProvider.notifier).addContact(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
