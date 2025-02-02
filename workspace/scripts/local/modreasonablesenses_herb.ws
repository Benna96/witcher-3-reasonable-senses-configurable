/******************************************************************************/
/** Depends on W3Container.UpdateContainer changes.
/******************************************************************************/

@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	if ( theGame.GetInGameConfigWrapper().GetVarValue('ReasonableSenses', 'herbsGlow') == "false" )
	{
		focusModeHighlight = FMV_None;
		foliageFullEntry = 'fullnoglow';
	}
	else
	{
		focusModeHighlight = FMV_Interactive;
		foliageFullEntry = 'full';
	}
	
	wrappedMethod( spawnData );
}