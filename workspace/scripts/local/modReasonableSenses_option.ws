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
