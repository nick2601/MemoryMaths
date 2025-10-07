import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mathsgames/src/core/theme_wrapper.dart';
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ThemeWrapper.dyslexicScreen(
          isDarkMode: themeProvider.themeMode == ThemeMode.dark,
          child: _buildSettingsScreen(themeProvider),
        );
      },
    );
  }

  Widget _buildSettingsScreen(ThemeProvider themeProvider) {
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
                _buildSectionHeader('App Preferences', theme),
                SizedBox(height: 16),
                _buildAppPreferencesCard(theme, themeProvider),

                SizedBox(height: 24),

                // User Account Section
                _buildSectionHeader('Account', theme),
                SizedBox(height: 16),
                _buildAccountCard(theme),

                SizedBox(height: 24),

                // App Info Section
                _buildSectionHeader('About', theme),
                SizedBox(height: 16),
                _buildAboutCard(theme),

                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildAppPreferencesCard(ThemeData theme, ThemeProvider themeProvider) {
    return Card(
      elevation: 2,
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
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Toggle between light and dark themes',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      darkMode.value = value;
                      themeProvider.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                );
              },
            ),

            Divider(),

            // Sound Toggle
            ValueListenableBuilder<bool>(
              valueListenable: soundOn,
              builder: (context, isSound, child) {
                return ListTile(
                  leading: Icon(
                    isSound ? Icons.volume_up : Icons.volume_off,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Sound Effects',
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Enable or disable game sounds',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: Switch(
                    value: isSound,
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
              builder: (context, isVibrate, child) {
                return ListTile(
                  leading: Icon(
                    isVibrate ? Icons.vibration : Icons.phone_android,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Vibration',
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Enable or disable haptic feedback',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: Switch(
                    value: isVibrate,
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

  Widget _buildAccountCard(ThemeData theme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // User Report
            ListTile(
              leading: Icon(
                Icons.assessment,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                'Performance Report',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'View your learning progress and stats',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: _isGeneratingReport
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.arrow_forward_ios),
              onTap: _isGeneratingReport ? null : () => _generateReport(),
            ),

            Divider(),

            // Reset Progress
            ListTile(
              leading: Icon(
                Icons.refresh,
                color: theme.colorScheme.error,
              ),
              title: Text(
                'Reset Progress',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              subtitle: Text(
                'Clear all game data and start fresh',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: _isResetting
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.arrow_forward_ios),
              onTap: _isResetting ? null : () => _showResetDialog(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard(ThemeData theme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Share App
            ListTile(
              leading: Icon(
                Icons.share,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                'Share App',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'Share Memory Maths with friends',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _shareApp(),
            ),

            Divider(),

            // App Version
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                'App Version',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'Version 1.0.0',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: theme.textTheme.headlineSmall,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Reset Progress',
            style: theme.textTheme.headlineSmall,
          ),
          content: Text(
            'This will permanently delete all your game progress and statistics. This action cannot be undone.',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _resetProgress();
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _generateReport() async {
    setState(() {
      _isGeneratingReport = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userEmail = authProvider.currentUser?.email ?? '';

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserReportView(userEmail: userEmail),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate report: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() {
        _isGeneratingReport = false;
      });
    }
  }

  Future<void> _resetProgress() async {
    setState(() {
      _isResetting = true;
    });

    try {
      final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
      await dashboardProvider.clearAllData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Progress reset successfully'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reset progress: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() {
        _isResetting = false;
      });
    }
  }

  Future<void> _shareApp() async {
    try {
      await FlutterShare.share(
        title: 'Memory Maths',
        text: 'Check out Memory Maths - a fun way to improve your math skills!',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.example.mathsgames',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share app'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
