/* ------------------------- Base class for options ------------------------- */

abstract class IRsenseOption
{
	public const var xmlGroup : name;
	public const var xmlId : name;

	protected var config : CInGameConfigWrapper;
	protected var xmlType : string;

	private var currentValue : string;

	public function Init()
	{
		var configValue : string;

		config = theGame.GetInGameConfigWrapper();
		xmlType = config.GetVarDisplayType( xmlGroup, xmlId );

		currentValue = config.GetVarValue( xmlGroup, xmlId );
		OnValueChanged(currentValue);
	}

	public final function Apply()
	{
		currentValue = config.GetVarValue( xmlGroup, xmlId );
		OnValueChanged(currentValue);

		Apply_Impl();
	}

	protected function OnValueChanged( newValue : string ) {}
	protected function Apply_Impl();
}

/* ------------------------- Option change trigger -------------------------- */

@wrapMethod( CR4IngameMenu ) function OnOptionValueChanged(groupId:int, optionName:name, optionValue:string)
{
	var preventDefault : bool;
	var groupName : name;
	var i : int;
	var options : array< IRsenseOption >;
	var matchingOption : IRsenseOption;

	// If true is returned, it's not safe to continue executing
	// Continuing causes crash on difficulty change for example (issue #1 on GitHub)
	preventDefault = wrappedMethod( groupId, optionName, optionValue );
	if( preventDefault )
		return true;

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
