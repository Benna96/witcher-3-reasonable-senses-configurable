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
@addMethod( W3FastTravelEntity ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_SIGNPOST;
}

/* -------------------------- Registration & bugfix ------------------------- */

// Bugfix only, rest is done in _entities
@wrapMethod( W3FastTravelEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	SetFocusModeVisibility( FMV_Interactive ); // Without this not all signposts are highlighted
	return returnVal;
}
