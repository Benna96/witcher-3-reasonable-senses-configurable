/* ------------------------- Base class for options ------------------------- */

abstract class IRsenseOption
{
	public const var xmlGroup : name;
	public const var xmlId : name;
	protected const var defaultValue : string;

	protected var config : CInGameConfigWrapper;
	protected var xmlType : string;

	private var currentValue : string;

	public function Init()
	{
		var configValue : string;

		config = theGame.GetInGameConfigWrapper();
		xmlType = config.GetVarDisplayType( xmlGroup, xmlId );

		UpdateValueFromConfig();
	}

	public final function Apply()
	{
		UpdateValueFromConfig();

		Apply_Impl();
	}

	private function UpdateValueFromConfig()
	{
		var configValue : string;

		configValue = config.GetVarValue( xmlGroup, xmlId );

		if( IsMissingValue( configValue ))
		{
			config.SetVarValue( xmlGroup, xmlId, TranslateIntoConfigValue( defaultValue ) );
			currentValue = defaultValue;
		}

		else
		{
			currentValue = TranslateFromConfigValue( configValue );
			if( currentValue == "ERROR" )
				return;
		}

		LogChannel( 'ReasonableSenses', ToString() + ": value is " + currentValue + ", config value: " + configValue );

		OnValueChanged( currentValue );
	}

	private function IsMissingValue( value : string ) : bool
	{
		if( xmlType == "TOGGLE" && value == "" )
			return true;
		
		else if( xmlType == "OPTIONS" && value == "-1" )
			return true;
		
		else
			return false;
	}

	private function TranslateFromConfigValue( configValue : string ) : string
	{
		switch( xmlType )
		{
			case "TOGGLE":
				return configValue;
			
			case "OPTIONS":
				return config.GetVarOption( xmlGroup, xmlId, (int)configValue );
			
			default:
				LogChannel( 'ReasonableSenses', ToString() + ": Unsupported xmlType " + xmlType );
				return "ERROR";
		}
	}

	private function TranslateIntoConfigValue( value : string ) : string
	{
		var i : int;

		switch( xmlType )
		{
			case "TOGGLE":
				return value;
			
			case "OPTIONS":
				for( i = 0; i < config.GetVarOptionsNum( xmlGroup, xmlId ); i += 1 )
				{
					if( config.GetVarOption( xmlGroup, xmlId, i ) == value )
						return i;
				}
				LogChannel( 'ReasonableSenses', ToString() + ": Failed to translate value '" + value + "' into config value." );
				return "ERROR";
			
			default:
				LogChannel( 'ReasonableSenses', ToString() + ": Unsupported xmlType " + xmlType );
				return "ERROR";
		}
	}

	protected function OnValueChanged( newValue : string ) {}
	protected function Apply_Impl();
}

/* ------------------------- Option change trigger -------------------------- */

@wrapMethod( CR4IngameMenu ) function OnOptionValueChanged(groupId:int, optionName:name, optionValue:string)
{
	var returnVal : bool;
	var groupName : name;
	var i : int;
	var options : array< IRsenseOption >;
	var matchingOption : IRsenseOption;

	returnVal = wrappedMethod( groupId, optionName, optionValue );

	// groupId acts as groupIdx most of the time, but not always, which can cause GetGroupName to crash
	// See issue #1 on GitHub
	if( groupId >= mInGameConfigWrapper.GetGroupsNum() )
		return returnVal;

	groupName = mInGameConfigWrapper.GetGroupName(groupId);
	options = theGame.GetRsenseConfig().options;

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
		matchingOption.Apply();
	}

	return returnVal;
}

@wrapMethod( CR4IngameMenu ) function OnPresetApplied(groupId:name, targetPresetIndex:int)
{
	var returnVal : bool;
	var i : int;
	var options : array< IRsenseOption >;

	returnVal = wrappedMethod( groupId, targetPresetIndex );

	options = theGame.GetRsenseConfig().options;
	for( i = 0; i < options.Size(); i += 1 )
	{
		if( options[ i ].xmlGroup == groupId )
		{
			options[ i ].Apply();
		}
	}

	return returnVal;
}
