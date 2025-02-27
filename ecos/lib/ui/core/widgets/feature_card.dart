import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.svgAsset,
  });

  final IconData? icon;
  final String? svgAsset;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: double.infinity,
          height: 132,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: icon != null
                    ? Icon(icon, color: Colors.black, size: 32)
                    : SvgPicture.asset(
                        svgAsset!,
                        height: 32,
                        width: 32,
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
