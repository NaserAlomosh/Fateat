abstract class SigninStates {}

class SigninInitState extends SigninStates {}

class SigninNotFoundUserState extends SigninStates {}

class SigninEmailOrPasswordErrorState extends SigninStates {}

class SigninEnterEmailAndPasswordState extends SigninStates {}

class SigninPasswordErrorState extends SigninStates {}

class SigninSuccessState extends SigninStates {}

class SigninLoadingState extends SigninStates {}
