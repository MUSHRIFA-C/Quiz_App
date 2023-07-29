import 'package:flutter/material.dart';
import 'package:fluttertsk9/model.dart';
class Quizapp extends StatefulWidget {
  const Quizapp({Key? key}) : super(key: key);

  @override
  State<Quizapp> createState() => _QuizappState();
}

class _QuizappState extends State<Quizapp> {
  List questions = [

    Task(quest: "Human teeth are as strong as the teeth of a mature shark ", answer: true),
    Task(quest: "Is Mount Kilimanjaro the world’s tallest peak!", answer: false),
    Task(quest: 'The Great Wall of China is visible from space.', answer: false),
    Task(quest: "A group of owls is called a parliament.", answer: true),
    Task(quest: "The first Harry Potter book was published in 1995.", answer: false),
    Task(quest: "Mahatma Gandhi was awarded the Nobel Peace Prize.", answer: false),
  ];

  List<IconData> icon = [];
  int qnum = 0;
  int count = 0;
  int count1 = 0;


  String getQuestion() {
    return questions[qnum].quest;
  }

  bool getAnswers() {
    return questions[qnum].answer;
  }


  void getNextQn() {
    if (qnum < questions!.length) {
      qnum++;
    }
  }

  void clearQn() {
    count = 0;
    count1 = 0;
    qnum = 0;
    icon = [];
  }

  bool finishQn() {
    if (qnum >= questions!.length - 1) {
      return true;
    }
    else
      return false;
  }
  //userpickedanswer
  void ansQn(bool answer) {
    //correctanswer
    bool getanswer = getAnswers();
    setState(() {
      if (getanswer == answer) {
        icon.add(Icons.check);
        count++;
      } else {
        icon.add(Icons.close);
        count1++;
      }
      if (count >= 3) {
        openAlertWin();
        clearQn();
        icon = [];
      } else if (count1 >= 3) {
        openAlertFail();
        clearQn();
        icon = [];
      } else {
        getNextQn();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 240),
              child: Text(
                getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  ansQn(true);
                });
              },
              child: Text(
                  'True',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                fixedSize: Size(350, 55),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ansQn(false);
                });
              },
              child: Text(
                'False',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: Size(350, 55),
              ),
            ),


            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  for (var iconData in icon)
                    Icon(iconData, color: Colors.green[800], size: 35),
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
  
  void openAlertWin(){
    showDialog(
        context: context, builder: (context) => AlertDialog(
      title: Text('Congratulations!',
        style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text('You answered at least 3 questions correctly'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
            child: Text('OK', style: TextStyle(fontSize: 20)),
        ),
      ],
    ),
    );
  }

  void openAlertFail(){
    showDialog(
      context: context, builder: (context) => AlertDialog(
      title: Text('Oops!',
      style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text('You answered more than 3 questions incorrectly'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
          child: Text('OK', style: TextStyle(fontSize: 20)),
        ),
      ],
    ),
    );
  }
  
  
  
}
