import 'package:flutter/material.dart';
import '../models/attendance_mode.dart';

class ModeSelector extends StatelessWidget {
  final List<AttendanceMode> modes;
  final String? selectedModeId;
  final ValueChanged<String?> onChanged;

  const ModeSelector({
    super.key,
    required this.modes,
    required this.selectedModeId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedModeId,
      hint: const Text('Select Attendance Mode'),
      items: modes
          .map((mode) => DropdownMenuItem(
                value: mode.id.toString(),
                child: Text(mode.name),
              ))
          .toList(),
      onChanged: onChanged,
      isExpanded: true,
    );
  }
} 