// IMPORTANT: Both W3Door & W3NewDoor need support
// Why there are 2 door classes I don't know

/* ------------------------------ Option class ------------------------------ */

class CRsenseDoorGlowOption extends IRsenseGlowOption
{
	default xmlId = 'doorGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Door)entity || (W3NewDoor)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Door ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	theGame.GetRsenseConfig().doorGlowOption.RegisterEntity( this );
}

@wrapMethod( W3NewDoor ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	theGame.GetRsenseConfig().doorGlowOption.RegisterEntity( this );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Door )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Door ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().doorGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Door ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}

@addField( W3NewDoor )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3NewDoor ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().doorGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3NewDoor ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
