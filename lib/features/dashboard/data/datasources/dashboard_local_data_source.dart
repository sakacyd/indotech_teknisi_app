import 'package:indotech_teknisi_app/features/dashboard/data/models/assignment_model.dart';
import 'package:hive/hive.dart';

abstract interface class DashboardLocalDataSource {
  void cacheAssignments(List<AssignmentModel> assignments);
  List<AssignmentModel> getLastAssignments();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final Box box;

  DashboardLocalDataSourceImpl(this.box);
  @override
  void cacheAssignments(List<AssignmentModel> assignments) {
    box.clear();
    box.write(() {
      for (int i = 0; i < assignments.length; i++) {
        box.put(i.toString(), assignments[i].toJson());
        print(assignments[i].customerName);
      }
    });
  }

  @override
  List<AssignmentModel> getLastAssignments() {
    List<AssignmentModel> assignments = [];

    box.read(
      () => {
        for (int i = 0; i < box.length; i++)
          {assignments.add(AssignmentModel.fromJson(box.get(i.toString())))},
      },
    );

    return assignments;
  }
}
