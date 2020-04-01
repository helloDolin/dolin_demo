/*
 * @Author: shaolin 
 * @Date: 2020-04-01 11:04:24 
 * @Last Modified by:   shaolin 
 * @Last Modified time: 2020-04-01 11:04:24 
 */
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({@required this.child, Key key, this.isLoading})
      : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading ? const _LoadingView() : child;
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
