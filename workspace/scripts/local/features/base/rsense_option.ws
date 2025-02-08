/* ------------------------- Base class for options ------------------------- */

abstract class IRsenseOption
{
	public const var xmlGroup : name;
		default xmlGroup = 'ReasonableSenses';
	public const var xmlId : name;
	protected const var defaultValue : string;

	protected var config : CInGameConfigWrapper;

	public var currentValue : string;

	public function Init()
	{
		var configValue : string;

		config = theGame.GetInGameConfigWrapper();
		
		configValue = config.GetVarValue( xmlGroup, xmlId );
		if( StrLen( configValue ) == 0 )
		{
			config.SetVarValue( xmlGroup, xmlId, defaultValue );
			configValue = defaultValue;
		}

		currentValue = configValue;
	}

	public final function Apply( force : bool )
	{
		var configValue : string;
		var i : int;

		configValue = config.GetVarValue( xmlGroup, xmlId );
		if( force || ( configValue != currentValue ) )
		{
			currentValue = configValue;
			Apply_Impl();
		}
	}

	protected function Apply_Impl();
}

/* ------------------------- Option change trigger -------------------------- */

@wrapMethod( CR4IngameMenu ) function OnOptionValueChanged(groupId:int, optionName:name, optionValue:string)
{
	var groupName : name;
	var i : int;
	var options : array< IRsenseOption >;
	var matchingOption : IRsenseOption;

	wrappedMethod( groupId, optionName, optionValue );

	groupName = mInGameConfigWrapper.GetGroupName(groupId);
	options = theGame.GetRsenseConfig().GetAllOptions();

	for( i = 0; i < options.Size(); i += 1 )
	{
		if( options[ i ].xmlGroup == groupName && options[ i ].xmlId == optionName )
		{
			matchingOption = options[ i ];
			break;
		}
	}

	if( matchingOption )
	{
		matchingOption.Apply( true );
	}

	LogChannel( 'ReasonableSenses', "OnOptionValueChanged: " + groupName + ", " + optionName + ", " + optionValue );
}

@wrapMethod( CR4IngameMenu ) function OnPresetApplied(groupId:name, targetPresetIndex:int)
{
	var i : int;
	var options : array< IRsenseOption >;

	wrappedMethod( groupId, targetPresetIndex );

	options = theGame.GetRsenseConfig().GetAllOptions();
	for( i = 0; i < options.Size(); i += 1 )
	{
		if( options[ i ].xmlGroup == groupId )
		{
			options[ i ].Apply( false );
		}
	}
}
