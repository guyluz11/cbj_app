import 'package:auto_size_text/auto_size_text.dart';
import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Action row.
/// Contains device name and action name and sores more data like device id
class BindingActionWidget extends StatelessWidget {
  /// Get all and store all info about the action
  const BindingActionWidget({
    required this.deviceEntityBase,
    required this.propertyToChange,
    required this.actionToChange,
  });

  /// Cbj unique id of a device
  final DeviceEntityBase deviceEntityBase;

  /// The action for the device
  final String propertyToChange;

  /// The action for the device
  final String actionToChange;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue.withOpacity(0.3),
      child: ListTile(
        leading: const FaIcon(
          FontAwesomeIcons.lightbulb,
          color: Colors.yellow,
        ),
        title: AutoSizeText(
          '${deviceEntityBase.cbjEntityName.getOrCrash()!} - $propertyToChange',
          maxLines: 2,
        ),
        trailing: AutoSizeText(
          actionToChange,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
