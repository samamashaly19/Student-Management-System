import 'dart:io';

void main() {
  var manager = StudentManager();

 
  var adel = Student("Adel", 20, "S001", "12");
  adel.addSubject(Subject("Math", 90));
  adel.addSubject(Subject("Science", 85));

  var ibrahim = Student("Ibrahim", 19, "S002", "11");
  ibrahim.addSubject(Subject("Math", 70));
  ibrahim.addSubject(Subject("Science", 65));

  var zain = Student("Zain", 21, "S003", "12");
  zain.addSubject(Subject("Math", 95));
  zain.addSubject(Subject("Science", 90));

  var youssef = Student("Youssef", 22, "S004", "12");
  youssef.addSubject(Subject("Math", 60));
  youssef.addSubject(Subject("Science", 55));

  var mohamed = Student("Mohamed", 18, "S005", "10");
  mohamed.addSubject(Subject("Math", 80));
  mohamed.addSubject(Subject("Science", 75));

  manager.addStudent(adel);
  manager.addStudent(ibrahim);
  manager.addStudent(zain);
  manager.addStudent(youssef);
  manager.addStudent(mohamed);

  
  print("--- Highest & Lowest Grade ---");
  _printHighestAndLowestGrade(manager);

  print("\n--- Students Above Average ---");
  _printStudentsAboveAverage(manager);

  print("\n--- Students Below Average ---");
  _printStudentsBelowAverage(manager);

  
  print("\n--- Edge Case: No Students ---");
  var emptyManager = StudentManager();
  _printHighestAndLowestGrade(emptyManager);
  _printStudentsAboveAverage(emptyManager);
  _printStudentsBelowAverage(emptyManager);

  while (true) {
    print("📚 Welcome to the Student Management System 📚");
    print('1. Manage Students');
    print('2. Sort Students');
    print('3. Print Reports');
    print('4. Exit');
    stdout.write("Enter your choice: ");
    var choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      case 1:
        manageStudents(manager);
        break;
      case 2:
        sortStudents(manager);
        break;
      case 3:
        printReports(manager);
        break;
      case 4:
        return;
      default:
        print("Invalid choice. Please try again.");
    }
  }
}

void manageStudents(StudentManager manager) {
  print('\n Manage Students ');
  print('1. Add Student');
  print('2. Remove Student');
  print('3. Update Student');
  print('4. Manage Student Subjects');
  print('5. Display All Students');
  stdout.write('Enter your choice: ');
  var choice = int.tryParse(stdin.readLineSync() ?? '');

  switch (choice) {
    case 1:
      addStudent(manager);
      break;
    case 2:
      removeStudent(manager);
      break;
    case 3:
      updateStudent(manager);
      break;
    case 4:
      manageStudentSubjects(manager);
      break;
    case 5:
      manager.displayAllStudents();
      break;
    default:
      print('Invalid Choice');
  }
}

void addStudent(StudentManager manager) {
  stdout.write('Enter your name: ');
  String name = stdin.readLineSync() ?? '';
  stdout.write('Enter age: ');
  int age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  stdout.write('Enter student ID: ');
  var studentID = stdin.readLineSync() ?? '';
  stdout.write('Enter grade level: ');
  var gradeLevel = stdin.readLineSync() ?? '';

  var student = Student(name, age, studentID, gradeLevel);
  manager.addStudent(student);
  print('Student added successfully.');
}

void removeStudent(StudentManager manager) {
  stdout.write('Enter student ID to remove: ');
  var studentID = stdin.readLineSync() ?? '';
  manager.removeStudent(studentID);
  print('Student removed successfully.');
}

void updateStudent(StudentManager manager) {
  stdout.write('Enter student ID to update: ');
  var studentID = stdin.readLineSync() ?? '';
  stdout.write('Enter new name: ');
  String newName = stdin.readLineSync() ?? '';
  stdout.write('Enter new age: ');
  int newAge = int.parse(stdin.readLineSync() ?? '') ;
  stdout.write('Enter new grade level: ');
  var newGradeLevel = stdin.readLineSync() ?? '';

  manager.updateStudent(studentID, newName, newAge, newGradeLevel);
  print('Student updated successfully.');
}

void manageStudentSubjects(StudentManager manager) {
  stdout.write('Enter student ID: ');
  var studentID = stdin.readLineSync() ?? '';
  var student = manager.getStudent(studentID);

  if (student == null) {
    print('Student not found.');
    return;
  }

  print('\n Manage Student Subjects ');
  print('1. Add Subject');
  print('2. Remove Subject');
  print('3. Update Subject Grade');
  print('4. Display All Subjects & Grades');
  stdout.write('Enter your choice: ');
  var choice = int.tryParse(stdin.readLineSync() ?? '');

  switch (choice) {
    case 1:
      stdout.write('Enter subject name: ');
      String subjectName = stdin.readLineSync() ?? '';
      student.addSubject(Subject(subjectName, 0.0));
      print('Subject added successfully.');
      break;
    case 2:
      stdout.write('Enter subject name to remove: ');
      String subjectName = stdin.readLineSync() ?? '';
      student.removeSubject(subjectName);
      print('Subject removed successfully.');
      break;
    case 3:
      stdout.write('Enter subject name to update grade: ');
      String subjectName = stdin.readLineSync() ?? '';
      stdout.write('Enter new grade: ');
      double newGrade = double.parse(stdin.readLineSync() ?? '') ;
      student.updateSubjectGrade(subjectName, newGrade);
      print('Grade updated successfully.');
      break;
    case 4:
      print(student);
      break;
    default:
      print('Invalid Choice');
  }
}

void sortStudents(StudentManager manager) {
  print('\n Sort Students ');
  print('1. By Name');
  print('2. By Age');
  print('3. By Average Grade');
  stdout.write('Enter your choice: ');
  var choice = int.parse(stdin.readLineSync() ?? '');

  if (choice != null) {
    manager.sortStudents(choice);
  } else {
    print('Invalid choice');
  }
  print('Students sorted successfully.');
}

void printReports(StudentManager manager) {
  print('\n Print Reports ');
  print('1. Highest & Lowest Grade');
  print('2. Students Above Average');
  print('3. Students Below Average');
  print('4. Full Student List');
  stdout.write('Enter your choice: ');
  var choice = int.tryParse(stdin.readLineSync() ?? '');

  switch (choice) {
    case 1:
      _printHighestAndLowestGrade(manager);
      break;
    case 2:
      _printStudentsAboveAverage(manager);
      break;
    case 3:
      _printStudentsBelowAverage(manager);
      break;
    case 4:
      manager.displayAllStudents();
      break;
    default:
      print('Invalid choice');
  }
}

void _printHighestAndLowestGrade(StudentManager manager) {
  if (manager.students.isEmpty) {
    print('No students found');
    return;
  }

  Student? highestGradeStudent;
  Student? lowestGradeStudent;
  double highestGrade = double.negativeInfinity;
  double lowestGrade = double.infinity;

  for (var student in manager.students) {
    double averageGrade = student.calculateAverage();
    if (averageGrade > highestGrade) {
      highestGrade = averageGrade;
      highestGradeStudent = student;
    }
    if (averageGrade < lowestGrade) {
      lowestGrade = averageGrade;
      lowestGradeStudent = student;
    }
  }

  if (highestGradeStudent != null && lowestGradeStudent != null) {
    print('🌟 Highest Grade:');
    print('${highestGradeStudent.name} - Average Grade: $highestGrade');
    print('\n📉 Lowest Grade:');
    print('${lowestGradeStudent.name} - Average Grade: $lowestGrade');
  }
}

void _printStudentsAboveAverage(StudentManager manager) {
  if (manager.students.isEmpty) {
    print('No students found');
    return;
  }

  double overallAverage = _calculateOverallAverage(manager);
  print('\n Students Above Average (Overall Average: $overallAverage)');
  for (var student in manager.students) {
    double studentAverage = student.calculateAverage();
    if (studentAverage > overallAverage) {
      print('${student.name} - Average Grade: $studentAverage');
    }
  }
}

double _calculateOverallAverage(StudentManager manager) {
  if (manager.students.isEmpty) return 0.0;

  double total = 0.0;
  int count = 0;

  for (var student in manager.students) {
    double studentAverage = student.calculateAverage();
    total += studentAverage;
    count++;
  }

  return total / count;
}

void _printStudentsBelowAverage(StudentManager manager) {
  if (manager.students.isEmpty) {
    print('No students found');
    return;
  }

  double overallAverage = _calculateOverallAverage(manager);
  print('\n Students Below Average (Overall Average: $overallAverage)');
  for (var student in manager.students) {
    double studentAverage = student.calculateAverage();
    if (studentAverage < overallAverage) {
      print('${student.name} - Average Grade: $studentAverage');
    }
  }
}

class Person {
  String? name;
  int? age;

  @override
  String toString() {
    return "Name: $name, Age: $age";
  }
}

class Subject {
  String? name;
  double? grade;

  Subject(this.name, this.grade);

  @override
  String toString() {
    return "Subject Name: $name, Grade: $grade";
  }

  void updateGrade(double newGrade) {
    grade = newGrade;
  }
}

class Student extends Person {
  String? studentID;
  String? gradeLevel;
  List<Subject> subjects;

  Student(String name, int age, this.studentID, this.gradeLevel)
      : subjects = [] {
    this.name = name;
    this.age = age;
  }

  void addSubject(Subject subject) {
    subjects.add(subject);
  }

  void removeSubject(String subjectName) {
    subjects.removeWhere((subject) => subject.name == subjectName);
  }

  void updateSubjectGrade(String subjectName, double newGrade) {
    for (var subject in subjects) {
      if (subject.name == subjectName) {
        subject.updateGrade(newGrade);
        break;
      }
    }
  }

  double calculateAverage() {
    if (subjects.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var subject in subjects) {
      total += subject.grade ?? 0.0;
    }
    return total / subjects.length;
  }

  @override
  String toString() {
    String studentInfo = super.toString();
    String subjectsInfo = subjects.map((subject) => subject.toString()).join('\n');
    return "$studentInfo\nStudent ID: $studentID\nGrade Level: $gradeLevel\nSubjects:\n$subjectsInfo";
  }
}

class StudentManager {
  List<Student> students = [];

  void addStudent(Student student) {
    students.add(student);
  }

  void removeStudent(String studentID) {
    students.removeWhere((student) => student.studentID == studentID);
  }

  void updateStudent(String studentID, String newName, int newAge, String newGradeLevel) {
    for (var student in students) {
      if (student.studentID == studentID) {
        student.name = newName;
        student.age = newAge;
        student.gradeLevel = newGradeLevel;
        break;
      }
    }
  }

  Student? getStudent(String studentID) {
    return students.firstWhere((student) => student.studentID == studentID);
  }

  void displayAllStudents() {
    for (var student in students) {
      print(student);
    }
  }

  void sortStudents(int sortType) {
    switch (sortType) {
      case 1:
        students.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case 2:
        students.sort((a, b) => a.age!.compareTo(b.age!));
        break;
      case 3:
        students.sort((a, b) => b.calculateAverage().compareTo(a.calculateAverage()));
        break;
      default:
        print("Invalid sort type");
    }
  }
}