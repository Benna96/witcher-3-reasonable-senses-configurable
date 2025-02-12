/* ------------------------------ Option class ------------------------------ */

class CRsenseSignpostGlowOption extends IRsenseGlowOption
{
	default xmlId = 'signpostGlow';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3FastTravelEntity)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3FastTravelEntity ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().signpostGlowOption;
}

/* -------------------------- Registration & bugfix ------------------------- */

// Bugfix only, rest is done in _entities
@wrapMethod( W3FastTravelEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	SetFocusModeVisibility( FMV_Interactive ); // Without this not all signposts glow
}
