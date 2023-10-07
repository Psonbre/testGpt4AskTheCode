class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Le courriel ne peut être vide.";
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (!emailRegex.hasMatch(value)) {
      return "Veuillez saisir une adresse électronique valide.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return "Le mot de passe doit faire au moins 8 charactères";
    }
    return null;
  }

  static String? validateName(String? name){
    if (name == null || name.isEmpty){
      return "Le nom ne doit pas être vide";
    }
    return null;
  }
}
