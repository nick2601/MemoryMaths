import 'package:mathsgames/src/data/ComplexData.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';

class ComplexCalculationRepository {
  static List<int> listHasCode = <int>[];

  static getComplexData(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    int type = 1;

    if (level <= 6) {
      type = 1;
    } else if (level >= 6 && level <= 13) {
      type = 2;
    } else if (level >= 13) {
      type = 3;
    }

    List<ComplexModel> list = <ComplexModel>[];

    while (list.length < 5) {
      list.add(ComplexData.getComplexValues(type));
    }

    return list;
  }
}

void main() {
  for (int i = 1; i < 5; i++) {
    ComplexCalculationRepository.getComplexData(i);
  }
}
