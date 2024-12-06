import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _isWhisperMode = false;
  double _friendsPercentage = 50;
  bool _useLocation = false;
  bool _useWorkFilters = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Apply filters
              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Broadcast Mode Switch
          SwitchListTile(
            title: const Text('Whisper Mode'),
            subtitle: Text(
              _isWhisperMode
                  ? 'Messages are only visible to friends'
                  : 'Messages are visible to everyone',
            ),
            value: _isWhisperMode,
            onChanged: (value) {
              setState(() {
                _isWhisperMode = value;
              });
            },
          ),

          const Divider(),

          // Friends Percentage Slider
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Friends Percentage',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Show channels with at least ${_friendsPercentage.round()}% friends',
                ),
                Slider(
                  value: _friendsPercentage,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: '${_friendsPercentage.round()}%',
                  onChanged: (value) {
                    setState(() {
                      _friendsPercentage = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const Divider(),

          // Location Filters
          SwitchListTile(
            title: const Text('Location Filters'),
            subtitle: const Text('Show channels based on your location'),
            value: _useLocation,
            onChanged: (value) {
              setState(() {
                _useLocation = value;
              });
            },
          ),

          if (_useLocation) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Current Location'),
                    trailing: Icon(Icons.my_location),
                  ),
                  ListTile(
                    title: Text('Range'),
                    trailing: Text('5 km'),
                  ),
                ],
              ),
            ),
          ],

          const Divider(),

          // Work Filters
          SwitchListTile(
            title: const Text('Work Filters'),
            subtitle: const Text('Show work-related channels'),
            value: _useWorkFilters,
            onChanged: (value) {
              setState(() {
                _useWorkFilters = value;
              });
            },
          ),

          if (_useWorkFilters) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    title: Text('Development'),
                    value: true,
                    onChanged: null,
                  ),
                  CheckboxListTile(
                    title: Text('Design'),
                    value: false,
                    onChanged: null,
                  ),
                  CheckboxListTile(
                    title: Text('Marketing'),
                    value: false,
                    onChanged: null,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
