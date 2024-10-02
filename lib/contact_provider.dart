// contact_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'contact_model.dart';

// StateNotifier untuk mengelola daftar kontak
class ContactNotifier extends StateNotifier<List<Contact>> {
  ContactNotifier() : super([]);

  void addContact(Contact contact) {
    state = [...state, contact];
  }

  void removeContact(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}

// Provider untuk ContactNotifier
final contactProvider = StateNotifierProvider<ContactNotifier, List<Contact>>(
  (ref) => ContactNotifier(),
);
