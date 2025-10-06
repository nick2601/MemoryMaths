import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/login/login_view.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'app/auth_provider.dart';
import 'app/theme_provider.dart';
import 'reports/user_report_view.dart';

/// Settings screen with Material 3 design and dyslexic-friendly features
/// Provides user configurable options for the app
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingScreen();
  }
}

class _SettingScreen extends State<SettingScreen> {
  /// Value notifiers for app settings
  ValueNotifier<bool> soundOn = ValueNotifier(false);
  ValueNotifier<bool> darkMode = ValueNotifier(false);
  ValueNotifier<bool> vibrateOn = ValueNotifier(false);

  /// Loading indicators
  bool _isGeneratingReport = false;
  bool _isResetting = false;

  @override
  void dispose() {
    soundOn.dispose();
    darkMode.dispose();
    vibrateOn.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getSpeakerVol();
  }

  /// Initializes app settings from SharedPreferences
  Future<void> getSpeakerVol() async {
    soundOn.value = await getSound();
    vibrateOn.value = await getVibration();
    Future.delayed(Duration.zero, () {
      darkMode.value = Theme.of(context).brightness != Brightness.light;
    });
  }

  /// Handles back navigation
  void backClicks() {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          backClicks();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: backClicks,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _showLogoutDialog(theme),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Preferences Section
                _buildSectionHeader(theme, 'App Preferences', Icons.tune),
                _buildPreferencesCard(theme),

                SizedBox(height: 24),

                // Reports Section
                _buildSectionHeader(theme, 'Reports', Icons.analytics),
                _buildReportsCard(theme),

                SizedBox(height: 24),

                // Support Section
                _buildSectionHeader(theme, 'Support', Icons.help_outline),
                _buildSupportCard(theme),

                SizedBox(height: 24),

                // Data Management Section
                _buildSectionHeader(theme, 'Data Management', Icons.storage),
                _buildDataManagementCard(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Dark Mode Toggle
            ValueListenableBuilder<bool>(
              valueListenable: darkMode,
              builder: (context, isDark, child) {
                return ListTile(
                  leading: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: theme.textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    isDark ? 'Dark theme enabled' : 'Light theme enabled',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      darkMode.value = value;
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeTheme();
                    },
                  ),
                );
              },
            ),

            Divider(),

            // Sound Toggle
            ValueListenableBuilder<bool>(
              valueListenable: soundOn,
              builder: (context, isOn, child) {
                return ListTile(
                  leading: Icon(
                    isOn ? Icons.volume_up : Icons.volume_off,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Sound Effects',
                    style: theme.textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    isOn ? 'Sound effects enabled' : 'Sound effects disabled',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  trailing: Switch(
                    value: isOn,
                    onChanged: (value) {
                      soundOn.value = value;
                      setSound(value);
                    },
                  ),
                );
              },
            ),

            Divider(),

            // Vibration Toggle
            ValueListenableBuilder<bool>(
              valueListenable: vibrateOn,
              builder: (context, isOn, child) {
                return ListTile(
                  leading: Icon(
                    isOn ? Icons.vibration : Icons.phonelink_erase,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Vibration',
                    style: theme.textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    isOn ? 'Vibration enabled' : 'Vibration disabled',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  trailing: Switch(
                    value: isOn,
                    onChanged: (value) {
                      vibrateOn.value = value;
                      setVibration(value);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ListTile(
          leading: Icon(
            Icons.analytics,
            color: theme.colorScheme.primary,
          ),
          title: Text(
            'View Performance Reports',
            style: theme.textTheme.bodyLarge,
          ),
          subtitle: Text(
            'See your progress and statistics',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          trailing: _isGeneratingReport
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.chevron_right),
          onTap: _isGeneratingReport ? null : _generateReport,
        ),
      ),
    );
  }

  Widget _buildSupportCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.star, color: theme.colorScheme.primary),
              title: Text('Rate App', style: theme.textTheme.bodyLarge),
              subtitle: Text(
                'Rate us on the app store',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _rateApp,
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.share, color: theme.colorScheme.primary),
              title: Text('Share App', style: theme.textTheme.bodyLarge),
              subtitle: Text(
                'Share with friends and family',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _shareApp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataManagementCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ListTile(
          leading: Icon(
            Icons.delete_forever,
            color: theme.colorScheme.error,
          ),
          title: Text(
            'Reset All Data',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          subtitle: Text(
            'This will delete all your progress',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          trailing: _isResetting
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.error,
                ),
          onTap: _isResetting ? null : () => _showResetDialog(theme),
        ),
      ),
    );
  }

  void _showLogoutDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset All Data'),
        content: Text('This action cannot be undone. All your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _resetAllData();
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<void> _generateReport() async {
    setState(() {
      _isGeneratingReport = true;
    });

    try {
      // Get the authenticated user's email from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userEmail = authProvider.userEmail;

      if (userEmail == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please login to view reports'))
        );
        return;
      }

      // Navigate to reports screen with the actual user email
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserReportView(
            userEmail: userEmail,
          ),
        ),
      );
    } finally {
      setState(() {
        _isGeneratingReport = false;
      });
    }
  }

  Future<void> _resetAllData() async {
    setState(() {
      _isResetting = true;
    });

    try {
      // Since resetAllData method doesn't exist, we'll clear preferences manually
      final preferences = Provider.of<DashboardProvider>(context, listen: false).preferences;
      await preferences.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All data has been reset successfully'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reset data: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() {
        _isResetting = false;
      });
    }
  }

  void _rateApp() {
    // Simple placeholder dialog for rating since RateDialogView might not exist
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rate Our App'),
        content: Text('Thank you for using Memory Math! Please rate us on your app store.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Later'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Rate Now'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareApp() async {
    try {
      await FlutterShare.share(
        title: 'Memory Math',
        text: 'Check out this amazing math learning app!',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.example.mathsgames',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to share app at this time')),
      );
    }
  }
}
