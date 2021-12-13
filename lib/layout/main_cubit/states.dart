abstract class MainLayStates {}

class MainLayInitialState extends MainLayStates {}

class LoadingGetUserDataState extends MainLayStates {}

class SuccessGetUserDataState extends MainLayStates {}

class ErrorGetUserDataState extends MainLayStates {}

class NormalUserState extends MainLayStates {}

class AdminUserState extends MainLayStates {}

class MainLayChangeBottomNavState extends MainLayStates {}

class MainLayDrinkTypeSelected extends MainLayStates {}

class MainLayDrinkQuantitySelected extends MainLayStates {}

class MainLayGlassTypeSelected extends MainLayStates {}

class MainLaySugarSelected extends MainLayStates {}

class MainLayCDSugarSelected extends MainLayStates {}

class MainLayCoffeeTypeSelected extends MainLayStates {}
class MainLayCoffeeLevelSelected extends MainLayStates {}
class MainLaySingleCoffeeGlassTypeSelected extends MainLayStates {}
class MainLayDoubleCoffeeGlassTypeSelected extends MainLayStates {}
class MainLayCoffeeDoubleSelected extends MainLayStates {}
class MainLayCoffeeSugarSelected extends MainLayStates {}


class MainLayOrderLoading extends MainLayStates {}
class MainLayOrderDone extends MainLayStates {}


class MainLayOrderDeleteLoading extends MainLayStates {}
class MainLayOrderDeleteDone extends MainLayStates {}


class MainLayFavSelected extends MainLayStates {}
class MainLayFavOrderLoading extends MainLayStates {}
class MainLayFavOrderExisting extends MainLayStates {}
class MainLayFavOrderDone extends MainLayStates {}

class LoadingGetDrinksDataState extends MainLayStates {}
class SuccessGetDrinksDataState extends MainLayStates {}


class LoadingGetOrdersDataState extends MainLayStates {}
class SuccessGetOrdersDataState extends MainLayStates {}


class LoadingProfileImagePickedState extends MainLayStates {}
class SuccessProfileImagePickedState extends MainLayStates {}
class ErrorProfileImagePickedState extends MainLayStates {}


class SuccessUploadProfileImageState extends MainLayStates {}
class ErrorUploadProfileImageState extends MainLayStates {}


class ErrorUpdateUserDataState extends MainLayStates {}