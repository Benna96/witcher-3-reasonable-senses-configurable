/* ------------------ Apply config settings without reload ------------------ */

@wrapMethod( CR4IngameMenu ) function OnOptionValueChanged(groupId:int, optionName:name, optionValue:string)
{
	var groupName : name;

	wrappedMethod( groupId, optionName, optionValue );
	
	groupName = mInGameConfigWrapper.GetGroupName(groupId);
	if( groupName == 'ReasonableSenses' && optionName == 'applySettings' && optionValue == "true" )
	{
		Rsense_ApplyChangedSettings();
	}
}

@addMethod( CR4IngameMenu ) private function Rsense_ApplyChangedSettings()
{
	var storage : CRsenseStorage;

	storage = theGame.GetRsenseStorage();

	if( !storage.HerbsGlowMatchesConfig() )
	{
		Rsense_UpdateHerbsVisibility( storage );
	}

	theGame.GetInGameConfigWrapper().SetVarValue( 'ReasonableSenses', 'applySettings', "false" );
	UpdateOptions( 'ReasonableSenses', false );
	storage.UpdateValuesFromConfig();

	theGame.GetGuiManager().ShowNotification( "Reasonable Senses: Applied changed settings" );
}

@addMethod( CR4IngameMenu ) private function Rsense_UpdateHerbsVisibility( storage : CRsenseStorage )
{
	var i : int;
	var herbs : array < W3Herb >;

	herbs = storage.herbs;
	for ( i = 0; i < herbs.Size(); i += 1 )
	{
		herbs[ i ].RequestUpdateContainer(); // UpdateContainer updates focus visibility among other things
	}
}