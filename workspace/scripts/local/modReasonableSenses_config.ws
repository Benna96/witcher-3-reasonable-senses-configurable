/* ------------------------- Add missing config vars ------------------------ */

@wrapMethod( CR4CommonMainMenuBase ) function OnConfigUI()
{
	wrappedMethod();
	ReasonableSenses_InitializeMissingConfigVars();
}

@addMethod( CR4CommonMainMenuBase ) function ReasonableSenses_InitializeMissingConfigVars()
{
	var config : CInGameConfigWrapper;

	config = theGame.GetInGameConfigWrapper();

	if ( !config.GetVarValue( 'ReasonableSenses', 'herbsGlow' ) )
		config.SetVarValue( 'ReasonableSenses', 'herbsGlow', "false" );
}