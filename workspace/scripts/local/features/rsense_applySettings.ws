/* ------------------------------ Option class ------------------------------ */

class CRsenseApplySettingsOption extends IRsenseOption
{
	default xmlId = 'applySettings';
	default defaultValue = "false";

	protected /* override */ function Apply_Impl()
	{
		var options : array< IRsenseOption >;
		var i : int;

		options = theGame.GetRsenseConfig().GetAllOptions();
		for( i = 0; i < options.Size(); i += 1 )
		{
			if( (CRsenseApplySettingsOption)options[ i ] )
				continue;
			
			options[ i ].Apply( false );
		}
	}
}

/* ------------------------------ Apply trigger ----------------------------- */

@wrapMethod( CR4IngameMenu ) function OnOptionValueChanged(groupId:int, optionName:name, optionValue:string)
{
	var applySettingsOption : CRsenseApplySettingsOption;
	var groupName : name;
	var i : int;

	wrappedMethod( groupId, optionName, optionValue );

	applySettingsOption = theGame.GetRsenseConfig().applySettingsOption;
	groupName = mInGameConfigWrapper.GetGroupName(groupId);

	if( groupName == applySettingsOption.xmlGroup && optionName == applySettingsOption.xmlId && optionValue )
	{
		applySettingsOption.Apply( true );

		theGame.GetInGameConfigWrapper().SetVarValue( groupName, optionName, "false" );
		UpdateOptions( groupName, false );

		theGame.GetGuiManager().ShowNotification( "Reasonable Senses: Applied changed settings" );
	}
}
