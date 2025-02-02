/* -------------------------------- Register -------------------------------- */

@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var storage : CRsenseStorage;
	var herbs : array < W3Herb >;

	storage = theGame.GetRsenseStorage();
	storage.herbs.PushBack( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Override mod values --------------------------- */
/*                             Used in _container                             */

@addMethod( W3Herb ) public function GetInteractiveFocusModeVisibility() : EFocusModeVisibility
{
	if ( theGame.GetInGameConfigWrapper().GetVarValue('ReasonableSenses', 'herbsGlow') == "false" )
	{
		return FMV_None;
	}
	else
	{
		return FMV_Interactive;
	}
}

@addMethod( W3Herb ) public function GetFoliageFullEntry() : name
{
	if ( theGame.GetInGameConfigWrapper().GetVarValue('ReasonableSenses', 'herbsGlow') == "false" )
	{
		return 'fullnoglow';
	}
	else
	{
		return 'full';
	}
}