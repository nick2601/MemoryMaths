import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/reports/user_report_provider.dart';
import 'package:mathsgames/src/ui/reports/user_report_view.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: getBackGroundColor(context),
      appBar: AppBar(
        title: Text('Your Progress Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: authProvider.isAuthenticated
          ? _buildReportContent(context, authProvider.userEmail ?? 'user@example.com')
          : _buildLoginPrompt(context),
    );
  }

  Widget _buildReportContent(BuildContext context, String userEmail) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            context,
            'Performance Analytics',
            'View detailed analysis of your progress in all math games',
            Icons.analytics,
            () => _navigateToUserReportView(context, userEmail),
            Colors.blue,
          ),
          SizedBox(height: 16),
          _buildInfoCard(
            context,
            'Skill Assessment',
            'Discover your mathematical strengths and areas for improvement',
            Icons.pie_chart,
            () => _navigateToUserReportView(context, userEmail, initialTab: 2),
            Colors.purple,
          ),
          SizedBox(height: 16),
          _buildInfoCard(
            context,
            'Learning Recommendations',
            'Get personalized recommendations to improve your skills',
            Icons.lightbulb_outline,
            () => _navigateToUserReportView(context, userEmail, initialTab: 3),
            Colors.orange,
          ),
          SizedBox(height: 16),
          _buildInfoCard(
            context,
            'Achievements',
            'See badges and milestones you\'ve earned',
            Icons.emoji_events,
            () => _navigateToUserReportView(context, userEmail, initialTab: 4),
            Colors.green,
          ),
          SizedBox(height: 24),
          _buildReportDescription(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Please log in to view your reports',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to login screen
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Log In'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to signup screen
              Navigator.pushNamed(context, '/signup');
            },
            child: Text('Create Account'),
          ),
        ],
      ),
    );
  }

  Widget _buildReportDescription(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Progress Reports',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your math activity is automatically tracked to provide personalized insights '
            'and recommendations. Reports show your strengths, areas for improvement, '
            'and customized learning path suggestions.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _navigateToUserReportView(BuildContext context, String email, {int initialTab = 0}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserReportView(
          userEmail: email,
          initialTabIndex: initialTab,
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About Progress Reports'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpItem('Overview', 'Summary of your overall performance across all games'),
              _buildHelpItem('Game Reports', 'Detailed statistics for each game category'),
              _buildHelpItem('Skills', 'Assessment of your mathematical skills and abilities'),
              _buildHelpItem('Learning Path', 'Personalized recommendations to improve'),
              _buildHelpItem('Achievements', 'Badges and milestones you\'ve earned'),
              SizedBox(height: 16),
              Text(
                'Reports are generated based on your gameplay activity. The more you play, the more accurate your reports will be!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
