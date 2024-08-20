import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/themes.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_typography.dart';

/// InboxScreen
class InboxScreen extends StatelessWidget {
  final Widget child;

  const InboxScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _InboxScreen(key: key, child: child);
  }
}

class _InboxScreen extends StatefulWidget {
  final Widget child;

  const _InboxScreen({
    super.key,
    required this.child,
  });

  @override
  State<_InboxScreen> createState() => __InboxScreenState();
}

class __InboxScreenState extends State<_InboxScreen> {
  int _currentSection = 0;
  final List<Map<String, dynamic>> _sections = [
    {
      'label': 'Pengajuan kegiatan',
      'path': '/inbox-kegiatan',
    },
    {
      'label': 'Pengajuan Aduan',
      'path': '/inbox-aduan',
    },
    {
      'label': 'Pengajuan Surat',
      'path': '/inbox-pengajuan-surat',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const RumahKitaAppBar(
            middle: [
              BaseTypography(
                text: 'Inbox',
                type: 'h3',
                fontWeight: fBold,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 56.0,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              itemCount: _sections.length,
              itemBuilder: (context, idx) {
                return Container(
                  margin: EdgeInsets.only(
                    left: idx == 0 ? 16.0 : 0.0,
                    right: 16.0,
                  ),
                  child: BaseElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentSection = idx;
                      });
                      context.push(_sections[idx]['path']);
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 16.0,
                    ),
                    backgroundColor: idx == _currentSection ? cTeal : null,
                    foregroundColor: idx == _currentSection ? cWhite : null,
                    label: _sections[idx]['label'],
                    fontSize: fLabel,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
