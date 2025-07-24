import 'package:flutter/material.dart';

class SuggestItem extends StatelessWidget {
  const SuggestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://instagram.fsgn20-1.fna.fbcdn.net/v/t51.2885-15/509172123_17953054133977776_1499235394796415359_n.jpg?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjE0NDB4MTkwNC5zZHIuZjc1NzYxLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fsgn20-1.fna.fbcdn.net&_nc_cat=100&_nc_oc=Q6cZ2QGA3aGoj5kpA1Dd72yHSFuNEg24BgpTmASxe0LK9nfxsizuJd9ixEHlBksOO7E-DriTe8ZS5zxEyhcCm6BR0hM6&_nc_ohc=pdZskyjJk1MQ7kNvwGf4gXZ&_nc_gid=E5l0UN6k9qq71kYx9mwurQ&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzY1NzcwNzAyMzQ5MzQ5MDI3OQ%3D%3D.3-ccb7-5&oh=00_AfTCuR7ScX1XkEZQYmO-NvJ2_3MqmAP2ys4WnyMOkGRU9Q&oe=68885D77&_nc_sid=7a9f4b',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Suggested User',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Handle follow action
            },
          ),
        ],
      ),
    );
  }
}
