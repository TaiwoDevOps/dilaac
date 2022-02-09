import 'package:dilaac/core/viewmodels/auth_vm.dart';
import 'package:dilaac/core/viewmodels/controller_vm.dart';
import 'package:dilaac/core/viewmodels/get_profile_vm.dart';
import 'package:dilaac/core/viewmodels/loader_vm.dart';
import 'package:dilaac/core/viewmodels/payment_link_vm.dart';
import 'package:dilaac/core/viewmodels/payout_vm.dart';
import 'package:dilaac/core/viewmodels/trans_historyvm.dart';
import 'package:dilaac/core/viewmodels/verify_email_vm.dart';
import 'package:dilaac/presentation/journeys/controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loaderVM = ChangeNotifierProvider((_) => LoaderVM());
final controllerVM = ChangeNotifierProvider((_) => ControllerVM());
final authVM = ChangeNotifierProvider((_) => AuthViewModel());
final verifyEmailOtpVM =
    ChangeNotifierProvider((_) => VerifyEmailOtpViewModel());

final userProfileVM = ChangeNotifierProvider((_) => UserProfileVM());
final transHistoryVM = ChangeNotifierProvider((_) => TransHistoryVM());
final paymentLinkVM = ChangeNotifierProvider((_) => PaymentLinkVM());
final payoutVM = ChangeNotifierProvider((_) => PayoutVm());
