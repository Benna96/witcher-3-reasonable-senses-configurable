/* --------------------------------- Storage -------------------------------- */

@addField( CR4Game )
private var rsenseStorage : CRsenseStorage;
@addMethod( CR4Game ) public function GetRsenseStorage() : CRsenseStorage
{
	if( !rsenseStorage )
	{
		rsenseStorage = new CRsenseStorage in theGame;
		rsenseStorage.Init();
	}
	
	return rsenseStorage;
}

@wrapMethod( CR4IngameMenu ) function LoadSaveRequested(saveSlotRef : SSavegameInfo) : void
{
	theGame.GetRsenseStorage().UpdateValuesFromConfig();
	wrappedMethod( saveSlotRef ); 
}

class CRsenseStorage
{
	private var config : CInGameConfigWrapper;

	public var herbsGlow : bool;

	public function Init()
	{
		config = theGame.GetInGameConfigWrapper();
		InitializeMissingConfigVars();
		UpdateValuesFromConfig();
	}

	private function InitializeMissingConfigVars()
	{
		if( StrLen(config.GetVarValue( 'ReasonableSenses', 'herbsGlow' )) == 0 )
			config.SetVarValue( 'ReasonableSenses', 'herbsGlow', "false" );
	}

	public function UpdateValuesFromConfig()
	{
		herbsGlow = config.GetVarValue( 'ReasonableSenses', 'herbsGlow' );
	}
}