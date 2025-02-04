/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerGlowOption extends IRsenseGlowOption
{
	default xmlId = 'containersGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}

	protected /* override */ function ApplyToEntity_Impl( entity : CGameplayEntity )
	{
		((W3Container)entity).RequestUpdateContainer(); // UpdateContainer updates focus visibility among other things
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Container ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().containerGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Container )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Container ) function /* override */ SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;

	if( focusModeVisibility == FMV_Interactive )
	{
		focusModeVisibility = GetInteractiveFocusModeVisibility();
	}

	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Container ) function /* override */ GetFocusModeVisibility() : EFocusModeVisibility
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

// Helper function needed because W3Herb has its own logic
@addMethod( W3Container ) protected function GetInteractiveFocusModeVisibility() : EFocusModeVisibility
{
	if( !theGame.GetRsenseConfig().containerGlowOption.currentValue )
	{
		return FMV_None;
	}
	else
	{
		return FMV_Interactive;
	}
}
