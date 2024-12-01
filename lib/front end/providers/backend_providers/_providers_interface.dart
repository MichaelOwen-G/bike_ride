
import 'package:flutter/cupertino.dart';

class ModelsProvider extends ChangeNotifier {
  List? _values;

  ModelsProvider({
       List? values,
  }) : _values = values;

  List? get values => _values;


  void changeValue(List newVal){
    _values = newVal;
    notifyListeners();
  }

  bool addItem(item){
    if (_values == null) return false;
    _values!.add(item);
    return true;
  }

  void removeItem(item){
    if (_values == null) return;
    _values!.removeWhere((e)=> e.id == item.id);
    changeValue(_values!);
  }


}