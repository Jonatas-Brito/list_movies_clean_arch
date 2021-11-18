import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/change_colors_indicator.dart';
import '../../domain/entities/movie.dart';

class AnimatedProgress extends StatefulWidget {
  final double percent;
  final Movie? movie;

  const AnimatedProgress({Key? key, this.movie, required this.percent})
      : super(key: key);
  @override
  _AnimatedProgressState createState() => _AnimatedProgressState();
}

class _AnimatedProgressState extends State<AnimatedProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation =
        Tween<double>(begin: 0.0, end: widget.percent).animate(_controller);
    _controller.forward();
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  Widget progress() {
    double percent = widget.percent;
    double animation = _animation.value;
    if (animation > 1) animation = 1;
    if (animation < 0) animation = 0;
    if (percent < 0) percent = 0;
    if (percent > 1) percent = 1;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.bastille,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 45,
              width: 45,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                value: _animation.value,
                backgroundColor: verifyColorSecondaryToPercent(percent),
                valueColor: AlwaysStoppedAnimation<Color>(
                    verifyColorPrimaryToPercent(percent)),
              ),
            ),
            Text(
              "${(_animation.value * 100).toInt()}%",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            )
          ],
        );
      },
    );
  }

  Future<Widget> getProgress() async =>
      await Future.delayed(Duration(microseconds: 10), () => progress());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProgress(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return progress();
          } else
            return Container();
        });
  }
}
