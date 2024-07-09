import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/formatters/ip_input_formatter.dart';

class ConnectBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController ipInputController;
  final TextEditingController portInputController;
  final TextEditingController serverIdInputController;
  final VoidCallback onConnectTap;

  const ConnectBottomSheet({
    required this.formKey,
    required this.ipInputController,
    required this.portInputController,
    required this.serverIdInputController,
    required this.onConnectTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border(
          top: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: Row(
                children: [
                  const Icon(Icons.new_releases),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'New Feature !',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Inspect network straight from your PC with '
              'Beyond Socket and Beyond Console',
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: ipInputController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'required';
                      }
                      return null;
                    },
                    inputFormatters: [
                      IpInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Web socket server IP',
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: ipInputController,
                        builder: (context, value, child) => Visibility(
                          visible: (value.text.isNotEmpty),
                          child: IconButton(
                            onPressed: ipInputController.clear,
                            icon: const Icon(
                              Icons.clear,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: portInputController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'required';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Port',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: serverIdInputController,
              textInputAction: TextInputAction.go,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'required';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                hintText: 'Server ID',
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: serverIdInputController,
                  builder: (context, value, child) => Visibility(
                    visible: (value.text.isNotEmpty),
                    child: IconButton(
                      onPressed: serverIdInputController.clear,
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// TODO: UNRELEASED FEATURE
                // FilledButton.tonalIcon(
                //   onPressed: () {},
                //   label: const Text(
                //     'Scan QR',
                //   ),
                //   icon: const Icon(
                //     Icons.qr_code_scanner_outlined,
                //   ),
                // ),
                // const SizedBox(
                //   width: 12,
                // ),
                FilledButton(
                  onPressed: onConnectTap,
                  child: const Text(
                    'Connect',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
