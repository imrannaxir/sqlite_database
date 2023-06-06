/*


 */
class NotesModel {
  final int? id;
  final String title;
  final int age;
  final String description;
  final String email;

  NotesModel({
    this.id,
    required this.title,
    required this.age,
    required this.description,
    required this.email,
  });

  NotesModel.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        title = result['title'],
        age = result['age'],
        description = result['description'],
        email = result['email'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'age': age,
      'description': description,
      'email': email,
    };
  }
}


//class Dog {
//   final int id;
//   final String name;
//   final int age;

//   Dog({
//     required this.id,
//     required this.name,
//     required this.age,
//   });

//   // Convert a Dog into a Map. The keys must correspond
//   // to the names of the columns in the database.
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//     };
//   }

//   @override
//   String toString() {
//     return 'Dog{id: $id, name: $name, age: $age}';
//   }
// }
