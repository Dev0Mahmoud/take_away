abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

class AdminChangeBottomNavState extends AdminStates {}

class LoadingGetUserDataState extends AdminStates {}
class SuccessGetUserDataState extends AdminStates {}
class ErrorGetUserDataState extends AdminStates {}


class LoadingProfileImagePickedState extends AdminStates {}
class SuccessProfileImagePickedState extends AdminStates {}
class ErrorProfileImagePickedState extends AdminStates {}


class SuccessUploadProfileImageState extends AdminStates {}
class ErrorUploadProfileImageState extends AdminStates {}


class ErrorUpdateUserDataState extends AdminStates {}


