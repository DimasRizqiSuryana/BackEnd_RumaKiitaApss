import 'package:flutter/material.dart';

/// KerjaBaktiDocumentationSreen
class KerjaBaktiDocumentationSreen extends StatelessWidget {
  final int id;

  const KerjaBaktiDocumentationSreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return _KerjaBaktiDocumentationScreen(
      key: key,
      id: id,
    );
  }
}

class _KerjaBaktiDocumentationScreen extends StatefulWidget {
  final int id;

  const _KerjaBaktiDocumentationScreen({
    super.key,
    required this.id,
  });

  @override
  State<_KerjaBaktiDocumentationScreen> createState() =>
      __KerjaBaktiDocumentationScreenState();
}

class __KerjaBaktiDocumentationScreenState
    extends State<_KerjaBaktiDocumentationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
