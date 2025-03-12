/* ------------------------------ Option class ------------------------------ */

class CRsenseSignpostHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'signpostHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3FastTravelEntity)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3FastTravelEntity ) protected /* override */ function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().signpostHighlightOption;
}

/* -------------------------- Registration & bugfix ------------------------- */

// Bugfix only, rest is done in _entities
@wrapMethod( W3FastTravelEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	if( wrappedMethod( spawnData ) == true )
		return true;
	
	SetFocusModeVisibility( FMV_Interactive ); // Without this not all signposts are highlighted
}
