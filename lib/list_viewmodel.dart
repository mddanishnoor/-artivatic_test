import 'package:api_call/api_service.dart';
import 'package:api_call/data_modal.dart';
import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

class ListViewModal extends ChangeNotifier {
  ApiService _apiService = ApiService();

  List<DataModal> data = [];
  getData() async {
    data = await _apiService.fetchData();
  }

  checkForData() async {
    await _apiService.fetchData();
  }

  update(DataModal user, DataModal updatedData) {
    data.indexWhere((element) {
      if (element.id == user.id) {
        element = updatedData;
        print("user updated");
        return true;
      } else {
        return false;
      }
    });
    notifyListeners();
  }

  create(DataModal user) {
    data.insert(data.length, user);
    print("user created");
    notifyListeners();
  }

  delete(int index) {
    data.removeAt(index);
    print("user deleted");
    notifyListeners();
  }
}
