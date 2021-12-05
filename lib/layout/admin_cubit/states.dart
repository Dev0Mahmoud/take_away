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


class LoadingAddDrinkState extends AdminStates {}
class SuccessAddDrinkState extends AdminStates {}
class ErrorAddDrinkState extends AdminStates {}

class LoadingDrinkImagePickedState extends AdminStates {}
class SuccessDrinkImagePickedState extends AdminStates {}
class ErrorDrinkImagePickedState extends AdminStates {}

class SuccessUploadDrinkImageState extends AdminStates {}
class ErrorUploadDrinkImageState extends AdminStates {}

class ErrorUpdateDrinkDataState extends AdminStates {}

class LoadingGetDrinksDataState extends AdminStates {}
class SuccessGetDrinksDataState extends AdminStates {}
class ErrorGetDrinksDataState extends AdminStates {}


class LoadingGetOrdersDataState extends AdminStates {}
class SuccessGetOrdersDataState extends AdminStates {}



