/* ------------------------- Base class for options ------------------------- */

abstract class IRsenseOption
{
	public const var xmlGroup : name;
		default xmlGroup = 'ReasonableSenses';
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

		currentValue = GetValueFromConfig();
		OnValueChanged(currentValue);
	}

	public final function Apply()
	{
		currentValue = GetValueFromConfig();
		OnValueChanged(currentValue);

		Apply_Impl();
	}

	private function GetValueFromConfig() : string
	{
		var value : string;

		value = config.GetVarValue( xmlGroup, xmlId );
		if( StrLen( value ) == 0 )
		{
			config.SetVarValue( xmlGroup, xmlId, defaultValue );
			value = defaultValue;
		}

		return value;
	}

	protected function OnValueChanged( newValue : string ) {}
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
		matchingOption.Apply();
	}
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
			options[ i ].Apply();
		}
	}
}
