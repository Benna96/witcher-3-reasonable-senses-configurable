/* ------------------------------ Option class ------------------------------ */

class CRsenseSignpostGlowOption extends IRsenseGlowOption
{
	default xmlId = 'signpostGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3FastTravelEntity)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _mapPinEntities
@addMethod( W3FastTravelEntity ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().signpostGlowOption;
}

/* -------------------------- Registration & bugfix ------------------------- */

@wrapMethod( W3FastTravelEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	SetFocusModeVisibility( FMV_Interactive ); // Without this not all signposts glow
	GetGlowOption().RegisterEntity( this );
}
