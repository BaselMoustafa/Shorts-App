enum AuthanticationMethod{
  emailAndPassword,
  google,
}

String fromAuthanticationMethodToString(AuthanticationMethod authanticationMethod){
  if(authanticationMethod==AuthanticationMethod.emailAndPassword){
    return "emailAndPassword";    
  }
  return "google";
}