import 'dart:async';
import 'package:products_store/core/common/firebase_error_mapper.dart';
import 'package:products_store/features/auth/auth.dart';
import 'package:products_store/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignIn signIn;
  final SignUp signUp;
  final SendPasswordReset sendPasswordReset;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  final AuthRepository repository;
  late final StreamSubscription _authSub;


  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.sendPasswordReset,
    required this.signOut,
    required this.getCurrentUser,
    required this.repository,
  }) : super(AuthInitial()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<PasswordResetRequested>(_onPasswordResetRequested);
    on<SignOutRequested>(_onSignOutRequested);

    // 🔑 Listen to Firebase auth state
    _authSub = repository.authStateChanges.listen((user) {
      add(AuthStatusChanged(user));
    });
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signIn(email: event.email, password: event.password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthFailure('Sign in failed'));
      }
    } catch (e) {
      emit(AuthFailure(mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUp(name: event.name, email: event.email, password: event.password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthFailure('Sign up failed'));
      }
    } catch (e) {
      emit(AuthFailure(mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  Future<void> _onPasswordResetRequested(PasswordResetRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await sendPasswordReset(email: event.email);
      emit(AuthPasswordReset());
    } catch (e) {
      emit(AuthFailure(mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(mapFirebaseAuthExceptionToMessage(e)));
    }
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }

}
