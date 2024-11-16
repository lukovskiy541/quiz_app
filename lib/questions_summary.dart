

import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  QuestionsSummary(this.data, {super.key});

  final List<Map<String, Object>> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: 
            data.map((data) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor:data['user_answer'] ==  data['correct_answer'] ? Colors.lightBlue: const Color.fromARGB(255, 196, 66, 109),
                    child: Text(((data['question_index'] as int) + 1).toString(),  style:const  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        (data['question'] as String), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        (data['user_answer'] as String), style: const TextStyle(color:  Color.fromARGB(255, 196, 66, 109)),
                      ),
                 
                      Text(
                        (data['correct_answer'] as String), style: const TextStyle(color: Colors.lightBlue),
                      ),
                    ],),
                  ),
                ],
              );
            }).toList(),
        ),
      ),
    );
  }
}
