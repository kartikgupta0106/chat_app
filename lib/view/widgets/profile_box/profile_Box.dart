import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ProfileBox extends StatelessWidget{

  final String imageUrl;
  final String name;
  final double width;
  final Callback onTap;

  const ProfileBox({Key? key, required this.name , required this.imageUrl , required this.width , required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: width-20,
        margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            // Image.network(imageUrl),
            CachedNetworkImage(
              imageUrl: imageUrl , width: 60 , height: 60 ,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 40,),
            Text(name , style: const TextStyle(fontSize: 20 , color: Colors.black87),)
          ],
        ),
      ),
    );
  }


}