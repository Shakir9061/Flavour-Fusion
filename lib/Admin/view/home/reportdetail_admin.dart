import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class ReportDetails_Admin extends StatefulWidget {
  final String reportId;
  final Map<String, dynamic> reportData;

  const ReportDetails_Admin({
    super.key,
    required this.reportId,
    required this.reportData,
  });

  @override
  State<ReportDetails_Admin> createState() => _ReportDetails_AdminState();
}

class _ReportDetails_AdminState extends State<ReportDetails_Admin> {
  bool _isUpdating = false;

  Future<void> _updateReportStatus(String newStatus) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('reports')
          .doc(widget.reportId)
          .update({
        'status': newStatus,
        'reviewedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report status updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating status: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timestamp = widget.reportData['timestamp'] as Timestamp?;
    final formattedDate = timestamp != null
        ? DateFormat('MMM dd, yyyy HH:mm').format(timestamp.toDate())
        : 'Date not available';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Report Details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              title: 'Report Status',
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(widget.reportData['status'] ?? 'pending'),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.reportData['status']?.toUpperCase() ?? 'PENDING',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              title: 'Reporter Information',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText1(
                    text: 'Name: ${widget.reportData['reporterName'] ?? 'Anonymous'}',
                    size: 16,
                    weight: FontWeight.normal,
                  ),
                  SizedBox(height: 8),
                  CustomText1(
                    text: 'Reporter ID: ${widget.reportData['reporterId'] ?? 'N/A'}',
                    size: 14,
                    weight: FontWeight.normal,
                  ),
                  SizedBox(height: 8),
                  CustomText1(
                    text: 'Submitted: $formattedDate',
                    size: 14,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              title: 'Report Content',
              child: CustomText1(
                text: widget.reportData['content'] ?? 'No content provided',
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              title: 'Reported User',
              child: CustomText1(
                text: 'User ID: ${widget.reportData['reportedUserId'] ?? 'N/A'}',
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 24),
            if (widget.reportData['status'] != 'resolved')
              _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff313131),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText1(
            text: title,
            size: 18,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isUpdating
                ? null
                : () => _updateReportStatus('reviewed'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isUpdating
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text('Mark as Reviewed'),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isUpdating
                ? null
                : () => _updateReportStatus('resolved'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isUpdating
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text('Mark as Resolved'),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'reviewed':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}