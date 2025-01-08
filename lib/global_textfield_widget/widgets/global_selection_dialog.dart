// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:global_textfield/global_textfield_widget/model/dropdownvalue_model.dart';
import 'package:global_textfield/global_textfield_widget/factory/common_scrollbar.dart';

class GlobalSelectionDialog<T> extends StatelessWidget {
  final List<GrobalDropdownItemModel<T>> items;
  final Widget Function(GrobalDropdownItemModel<T> item) selectedItemBuilder;

  const GlobalSelectionDialog(
      {super.key, required this.items, required this.selectedItemBuilder});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final filteredItemsNotifier =
        ValueNotifier<List<GrobalDropdownItemModel<T>>>(items);
    void _filterItems(String query) {
      filteredItemsNotifier.value = items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    searchController.addListener(() {
      _filterItems(searchController.text);
    });
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // Search TextField
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: Builder(builder: (context) {
                  if (items.isEmpty) {
                    return const Center(child: Text('Empty Data List'));
                  }

                  return CommonScrollableWithControls(
                    child: ValueListenableBuilder<
                        List<GrobalDropdownItemModel<T>>>(
                      valueListenable: filteredItemsNotifier,
                      builder: (context, filteredItems, _) {
                        if (filteredItemsNotifier.value.isEmpty) {
                          return const Center(
                              child: Text('No Search Key word found'));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return ListTile(
                              title: selectedItemBuilder.call(item),
                              onTap: () {
                                Navigator.of(context).pop(item);
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
