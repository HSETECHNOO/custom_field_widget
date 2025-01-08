class SchoolData {
  final String id;
  final String name;
  final String address;
  final int numberOfStudents;
  final String principalName;
  final String contactNumber;
  final List<String> facilities;

  SchoolData({
    required this.id,
    required this.name,
    required this.address,
    required this.numberOfStudents,
    required this.principalName,
    required this.contactNumber,
    required this.facilities,
  });
}

var schoolList = [
  SchoolData(
    id: "S1",
    name: "Green Valley High School",
    address: "123 Main Street, Springfield",
    numberOfStudents: 500,
    principalName: "John Doe",
    contactNumber: "123-456-7890",
    facilities: ["Library", "Sports Ground", "Computer Lab", "Science Lab"],
  ),
  SchoolData(
    id: "S2",
    name: "Blue Ridge Academy",
    address: "456 Elm Street, Rivertown",
    numberOfStudents: 350,
    principalName: "Jane Smith",
    contactNumber: "987-654-3210",
    facilities: ["Swimming Pool", "Art Studio", "Cafeteria"],
  ),
  SchoolData(
    id: "S3",
    name: "Sunrise International School",
    address: "789 Oak Avenue, Lakeview",
    numberOfStudents: 800,
    principalName: "Emily Johnson",
    contactNumber: "555-123-4567",
    facilities: ["Auditorium", "Gymnasium", "Music Room"],
  ),
];

/////////////////////////////
class EmployeeModel {
  final int id;
  final String name;
  final String position;
  final double salary;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
  });
}

List<EmployeeModel> employees = [
  EmployeeModel(
      id: 1, name: 'Alice Smith', position: 'Software Engineer', salary: 70000),
  EmployeeModel(
      id: 2, name: 'Bob Johnson', position: 'Product Manager', salary: 85000),
  EmployeeModel(
      id: 3, name: 'Charlie Brown', position: 'UX/UI Designer', salary: 60000),
  EmployeeModel(
      id: 4,
      name: 'David Williams',
      position: 'Quality Analyst',
      salary: 55000),
  EmployeeModel(
      id: 5, name: 'Eve Davis', position: 'Marketing Manager', salary: 75000),
];
