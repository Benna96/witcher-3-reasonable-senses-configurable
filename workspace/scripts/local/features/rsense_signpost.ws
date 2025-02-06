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

/* -------------------------- Registration & bugfix ------------------------- */

@wrapMethod( W3FastTravelEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().signpostGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
	SetFocusModeVisibility( FMV_Interactive ); // Without this not all signposts glow
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3FastTravelEntity )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3FastTravelEntity ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().signpostGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3FastTravelEntity ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
