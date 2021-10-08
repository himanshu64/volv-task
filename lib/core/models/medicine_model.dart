import 'package:equatable/equatable.dart';

class MedicineModel extends Equatable{

  late final String problemType;
  late final List<dynamic>  medications;
  late final List<dynamic>  labs;

  MedicineModel({required this.problemType,required this.medications,required this.labs});
  
  factory MedicineModel.fromJson(Map<String, dynamic> result) {
    return MedicineModel(problemType: result['problems'], labs: [], medications: []);
  }
 
  @override
  List<Object?> get props => [problemType, medications, labs];
}
  
