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
	theGame.GetRsenseStorage().ClearSensoryLists(); // OnSpawned is called on load & populates lists
	wrappedMethod( saveSlotRef ); 
}
@wrapMethod( CR4CommonMainMenuBase ) function OnConfigUI()
{
	theGame.GetRsenseStorage().ClearSensoryLists(); // Doesn't matter much, cleared on LoadSave too
	wrappedMethod();
}

class CRsenseStorage
{
	private var config : CInGameConfigWrapper;

	public var herbsGlow : bool;
	public var containersGlow : bool;

	public var herbs : array< W3Herb >;
	public var containers : array< W3Container >;

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
		
		if( StrLen(config.GetVarValue( 'ReasonableSenses', 'containersGlow' )) == 0 )
			config.SetVarValue( 'ReasonableSenses', 'containersGlow', "false" );
	}

	public function UpdateValuesFromConfig()
	{
		herbsGlow = config.GetVarValue( 'ReasonableSenses', 'herbsGlow' );
		containersGlow = config.GetVarValue( 'ReasonableSenses', 'containersGlow' );
	}

	public function ClearSensoryLists()
	{
		herbs.Clear();
		containers.Clear();
	}

	public function HerbsGlowMatchesConfig() : bool
	{
		return (string)herbsGlow == theGame.GetInGameConfigWrapper().GetVarValue( 'ReasonableSenses', 'herbsGlow' );
	}
	public function ContainersGlowMatchesConfig() : bool
	{
		return (string)containersGlow == theGame.GetInGameConfigWrapper().GetVarValue( 'ReasonableSenses', 'containersGlow' );
	}
}