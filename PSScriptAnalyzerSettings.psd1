@{
  #Severity=@('Error', 'Warning')
  IncludeRules=@(
    'PSAvoidTrailingWhitespace'
  )
  ExcludeRules=@(
    'PSUseShouldProcessForStateChangingFunctions',
    'PSAvoidGlobalVars',
    'PSUseDeclaredVarsMoreThanAssignments'
  )
}
