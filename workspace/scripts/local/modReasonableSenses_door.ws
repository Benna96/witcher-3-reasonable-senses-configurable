/* ------------------------------ Option class ------------------------------ */

class CRsenseDoorGlowOption extends IRsenseGlowOption
{
	default xmlId = 'doorsGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Door)entity || (W3NewDoor)entity;
	}

	protected /* override */ function ApplyToEntity_Impl( entity : CGameplayEntity )
	{
		entity.SetFocusModeVisibility(entity.GetFocusModeVisibility());
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

	if( focusModeVisibility == FMV_Interactive && !theGame.GetRsenseConfig().doorGlowOption.currentValue )
	{
		focusModeVisibility = FMV_None;
	}

	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );

	LogChannel( 'ReasonableSenses', "Door SetFocusModeVisibility(" + cachedFocusModeVisiblity + "), actually setting to " + focusModeVisibility );
}
@addMethod( W3Door ) function /* override */ GetFocusModeVisibility() : EFocusModeVisibility
{
	var superValue : EFocusModeVisibility;

	superValue = super.GetFocusModeVisibility();

	// Ensure clue highlight is always returned, even if set through engine
	if( superValue == FMV_Clue )
	{
		return superValue;
	}
	
	else
	{
		return cachedFocusModeVisiblity;
	}
}

// Why there are 2 door classes I don't know...
@addField( W3NewDoor )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3NewDoor ) function /* override */ SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;

	if( focusModeVisibility == FMV_Interactive && !theGame.GetRsenseConfig().doorGlowOption.currentValue )
	{
		focusModeVisibility = FMV_None;
	}

	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );

	LogChannel( 'ReasonableSenses', "Door SetFocusModeVisibility(" + cachedFocusModeVisiblity + "), actually setting to " + focusModeVisibility );
}
@addMethod( W3NewDoor ) function /* override */ GetFocusModeVisibility() : EFocusModeVisibility
{
	var superValue : EFocusModeVisibility;

	superValue = super.GetFocusModeVisibility();

	// Ensure clue highlight is always returned, even if set through engine
	if( superValue == FMV_Clue )
	{
		return superValue;
	}
	
	else
	{
		return cachedFocusModeVisiblity;
	}
}
