import 'package:flutter/material.dart';

class Subject {
  TextEditingController hoursController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Subject> subjects = [Subject()];

  double totalPoints = 0;
  double totalHours = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester GPA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Semester GPA:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildSubjectsInputs(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateSemesterGPA();
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
              child: Text('Calculate Semester GPA'),
            ),
            SizedBox(height: 20),
            Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Semester GPA: ${totalPoints / totalHours}'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '© 2024 GPA Calculator. All rights reserved Sadiq Developer .',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildSubjectsInputs() {
    List<Widget> widgets = [];

    for (int i = 0; i < subjects.length; i++) {
      widgets.add(buildSubjectInput(i));
    }

    widgets.add(
      ElevatedButton(
        onPressed: () {
          addSubject();
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.secondary,
        ),
        child: Text('Add Subject'),
      ),
    );

    return Column(
      children: widgets,
    );
  }

  Widget buildSubjectInput(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Subject ${index + 1}:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: subjects[index].hoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Credit Hours',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: subjects[index].gradeController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Grade',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeSubject(index);
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ],
    );
  }

  void addSubject() {
    setState(() {
      subjects.add(Subject());
    });
  }

  void removeSubject(int index) {
    setState(() {
      subjects.removeAt(index);
    });
  }

  void calculateSemesterGPA() {
    try {
      totalPoints = 0;
      totalHours = 0;

      for (int i = 0; i < subjects.length; i++) {
        totalPoints += calculateSubjectPoints(
          subjects[i].hoursController.text,
          subjects[i].gradeController.text,
        );
        totalHours += double.parse(subjects[i].hoursController.text);
      }

      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  double calculateSubjectPoints(String hours, String grade) {
    double creditHours = double.parse(hours);
    double subjectPoints = 0;

    switch (grade.toUpperCase()) {
      case 'A+':
        subjectPoints = 4.0;
        break;
      case 'A':
        subjectPoints = 3.75;
        break;
      case 'B+':
        subjectPoints = 3.5;
        break;
      case 'B':
        subjectPoints = 3.0;
        break;
      case 'C+':
        subjectPoints = 2.5;
        break;
      case 'C':
        subjectPoints = 2.0;
        break;
      case 'D+':
        subjectPoints = 1.5;
        break;
      case 'D':
        subjectPoints = 1.0;
        break;
      case 'F':
        subjectPoints = 0.0;
        break;
      default:
        print('Invalid grade');
    }

    return creditHours * subjectPoints;
  }
}
