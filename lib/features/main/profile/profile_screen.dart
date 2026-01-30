import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/device.dart';
import '../../../../core/models/contact.dart';
import '../../../../core/widgets/search/search_bar_widget.dart';

/// Profile/Settings screen for Protectra app
/// Manages user profile, device settings, and trusted contacts
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Device _device;
  late List<Contact> _contacts;
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Contact> get _filteredContacts {
    if (_searchQuery.isEmpty) {
      return _contacts;
    }
    return _contacts.where((contact) {
      final query = _searchQuery.toLowerCase();
      return contact.name.toLowerCase().contains(query) ||
          contact.typeLabel.toLowerCase().contains(query) ||
          (contact.phoneNumber?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void _initializeMockData() {
    _device = Device.mock(batteryLevel: 78, status: DeviceStatus.connected);
    _contacts = [
      Contact.mock(
        name: 'Maria Santos',
        phoneNumber: '+639123456789',
        type: ContactType.parent,
        isEmergencyContact: true,
      ),
      Contact.mock(
        name: 'Juan Reyes',
        phoneNumber: '+639876543210',
        type: ContactType.friend,
        isEmergencyContact: true,
      ),
      Contact.mock(
        name: 'Ana Cruz',
        phoneNumber: '+639555555555',
        type: ContactType.guardian,
        isEmergencyContact: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUserProfile(),
          const SizedBox(height: 24),
          _buildDeviceSection(),
          const SizedBox(height: 24),
          _buildContactsSection(),
          const SizedBox(height: 24),
          _buildSettingsSection(),
          const SizedBox(height: 24),
          _buildAppInfo(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.textInverse.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.textInverse, width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/user (1).png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person_rounded,
                    size: 40,
                    color: AppColors.textInverse,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Device Wearer',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textInverse.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_rounded, color: AppColors.textInverse),
            onPressed: () {
              // Edit profile
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Paired Device', style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.watch_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _device.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          _device.isConnected
                              ? Icons.bluetooth_connected_rounded
                              : Icons.bluetooth_disabled_rounded,
                          size: 14,
                          color: _device.isConnected
                              ? AppColors.statusConnected
                              : AppColors.statusDisconnected,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _device.statusLabel,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: _device.isConnected
                                ? AppColors.statusConnected
                                : AppColors.statusDisconnected,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Trusted Contacts', style: AppTextStyles.titleMedium),
            TextButton.icon(
              onPressed: () => _showAddContactDialog(),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppSearchBar(
          hintText: 'Search contacts...',
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          onClear: () {
            setState(() {
              _searchQuery = '';
            });
          },
        ),
        const SizedBox(height: 12),
        ..._filteredContacts.map((contact) => _buildContactCard(contact)),
      ],
    );
  }

  Widget _buildContactCard(Contact contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                contact.initials,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      contact.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (contact.isEmergencyContact) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.dangerLevel3.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Emergency',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.dangerLevel3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  contact.typeLabel,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone_rounded),
            color: AppColors.primary,
            onPressed: () {
              // Call contact
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // Edit contact
              } else if (value == 'delete') {
                setState(() {
                  _contacts.remove(contact);
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_rounded, size: 18),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      size: 18,
                      color: AppColors.error,
                    ),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        _buildSettingItem(
          icon: Icons.notifications_rounded,
          title: 'Push Notifications',
          subtitle: 'Receive alerts on your device',
          trailing: Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
        ),
        _buildSettingItem(
          icon: Icons.location_on_rounded,
          title: 'Location Services',
          subtitle: 'Allow app to access location',
          trailing: Switch(
            value: _locationEnabled,
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
            },
          ),
        ),
        _buildSettingItem(
          icon: Icons.language_rounded,
          title: 'Language',
          subtitle: 'English',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {
            // Show language selection
          },
        ),
        _buildSettingItem(
          icon: Icons.dark_mode_rounded,
          title: 'Dark Mode',
          subtitle: 'Use system theme',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {
            // Show theme selection
          },
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTextStyles.bodyMedium),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildAppInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About', style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: AppColors.primary,
                    size: 48,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Protectra',
                        style: AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Safety Device Companion',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Version', '1.0.0'),
              _buildInfoRow('Build', '1'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Show privacy policy
                },
                child: const Text('Privacy Policy'),
              ),
              TextButton(
                onPressed: () {
                  // Show terms of service
                },
                child: const Text('Terms of Service'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter contact name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ContactType>(
              decoration: const InputDecoration(labelText: 'Relationship'),
              value: ContactType.parent,
              items: ContactType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.label));
              }).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _contacts.add(
                    Contact.mock(
                      name: nameController.text,
                      phoneNumber: phoneController.text,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

extension ContactTypeExtension on ContactType {
  String get label {
    switch (this) {
      case ContactType.parent:
        return 'Parent';
      case ContactType.guardian:
        return 'Guardian';
      case ContactType.friend:
        return 'Friend';
      case ContactType.relative:
        return 'Relative';
    }
  }
}
