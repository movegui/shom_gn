class MyValidators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display name must be between 3 and 20 characters';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if(value!.isEmpty){
       return 'Please Enter Phone Number';
    }

     if (value.length < 8) {
      return 'Phone Number muss be at least 8 characters long';
    }
    return null;

     
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? uploadProdTexts({String? value, String? toBeReturnedString}) {
    if (value!.isEmpty) {
      return toBeReturnedString;
    }
    return null;
  }
    static String? textValidator(String? value){
      if(value == null) return null;
    if(value.isEmpty) {
      return 'Vewuillez saisir la Categorie svp';
    }
    return null;
  }

    static String? textNameValidator(String? value){
    if(value!.isEmpty) {
      return 'Vewuillez saisir le Nom svp';
    }
    return null;
  }

  
      static String? numberValidator(String? value){
    if(value!.isEmpty) {
      return 'Vewuillez saisir le Nom svp';
    }
    return null;
  }


  static String? latitudeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Veuillez saisir la latitude svp';
  }

  final lat = double.tryParse(value);

  if (lat == null) {
    return 'Entrez un nombre valid svp';
  }

  if (lat < -90 || lat > 90) {
    return 'Latitude doit etre entre -90 and 90';
  }

  return null;
}
static String? longitudeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Veuillez saisir la longitude svp';
  }

  final lng = double.tryParse(value);

  if (lng == null) {
    return 'Entrez un nombre valid svp';
  }

  if (lng < -180 || lng > 180) {
    return 'Longitude doit etre  -180 and 180';
  }

  return null;
}
}
