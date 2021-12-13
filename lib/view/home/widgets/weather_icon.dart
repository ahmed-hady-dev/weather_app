import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class WeatherIcon extends StatefulWidget {
  final String weatherIcon;

  const WeatherIcon({
    Key? key,
    required this.weatherIcon,
  }) : super(key: key);

  @override
  State<WeatherIcon> createState() => _WeatherIconState();
}

class _WeatherIconState extends State<WeatherIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ))
    ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
          begin: const Offset(0, 0.1), end: Offset.zero)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: FadeInImage.memoryNetwork(
          fit: BoxFit.fitHeight,
          placeholder: kTransparentImage,
          image:
              'https://openweathermap.org/img/wn/${widget.weatherIcon}@4x.png'),
    );
  }
}
