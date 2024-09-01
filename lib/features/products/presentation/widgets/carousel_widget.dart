import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../domain/models/carousel_model.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final List<CarouselModel> _carousels = [
    CarouselModel("slider-1", "Shop new wears"),
    CarouselModel("slider-2", "Exclusive sales"),
  ];
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
            controller: _controller,
            itemCount: _carousels.length,
            options: CarouselOptions(
                onPageChanged: (int page, _) {
                  setState(() {
                    _current = page;
                  });
                },
                autoPlayInterval: const Duration(seconds: 10),
                viewportFraction: 1,
                autoPlay: true,
                height: 148),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
                height: 148,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${_carousels[itemIndex].image}.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              );
            }),
        Positioned(
          bottom: 10,
          left: 10,
          child: CustomText(
            title: _carousels[_current].text,
            color: Colors.white,
            size: 18,
            weight: FontWeight.w600,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _carousels.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: AnimatedContainer(
                    width: _current == entry.key ? 12 : 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: (Colors.white)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    duration: const Duration(milliseconds: 700),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
