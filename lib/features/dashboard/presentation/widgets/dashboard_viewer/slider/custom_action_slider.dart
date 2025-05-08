import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/bloc/dashboard_viewer/viewer_bloc.dart';

class CustomActionSlider extends StatefulWidget {
  final String text;
  final VoidCallback onSuccess;

  const CustomActionSlider({
    super.key,
    required this.text,
    required this.onSuccess,
  });

  @override
  State<CustomActionSlider> createState() => _CustomActionSliderState();
}

class _CustomActionSliderState extends State<CustomActionSlider> {
  late final ActionSliderController _controller;
  bool _isSliderEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = ActionSliderController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBlocState(ViewerState state) {
    if (state is ViewerCompleted && _isSliderEnabled) {
      setState(() {
        _isSliderEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewerBloc, ViewerState>(
      listener: (context, state) {
        _handleBlocState(state);
      },
      child: Center(
        child: AbsorbPointer(
          absorbing: !_isSliderEnabled,
          child: ActionSlider.standard(
            controller: _controller,
            action: (ctrl) async {
              if (!_isSliderEnabled) return;
              ctrl.loading();
              await Future.delayed(const Duration(milliseconds: 500));
              ctrl.success();
              widget.onSuccess();
              await Future.delayed(const Duration(milliseconds: 500));
              ctrl.reset();
            },
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}