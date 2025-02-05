/* ------------------------------ Option class ------------------------------ */

class CRsenseDoorGlowOption extends IRsenseGlowOption
{
	default xmlId = 'doorsGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Door)entity || (W3NewDoor)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Door ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().doorGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}
@wrapMethod( W3NewDoor ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().doorGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Door )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Door ) function /* override */ SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().doorGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Door ) function /* override */ GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}

// Why there are 2 door classes I don't know...
@addField( W3NewDoor )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3NewDoor ) function /* override */ SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().doorGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3NewDoor ) function /* override */ GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
