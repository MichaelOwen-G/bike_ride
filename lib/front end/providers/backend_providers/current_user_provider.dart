import 'package:bike_ride/back%20end/models/user.dart';
import 'package:bike_ride/front%20end/providers/backend_providers/_providers_interface.dart';


class CurrentUserProvider extends ModelsProvider {
  /// provides the logged in user

  CurrentUserProvider() : super(values: const <User>[]);

  User? get user {
    return values!.isEmpty ? null : values!.firstOrNull;
  }

  set user(User? user) {
    user == null ? changeValue([]) : changeValue([user]);
  }

}
