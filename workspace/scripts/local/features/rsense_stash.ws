/* ------------------------------ Option class ------------------------------ */

class CRsenseStashGlowOption extends IRsenseGlowOption
{
	default xmlId = 'stashGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Stash)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

// W3Stash doesn't define OnSpawned to wrap, & addMethod doesn't work with events
// Init, called by OnSpawned, is also called from EnableEntity,
// which makes me think it might run multiple times
@addField( W3Stash )
private var rsenseInitDone : bool;
@addMethod( W3Stash ) function /* override */ Init()
{
	super.Init();

	if( !rsenseInitDone )
	{
		theGame.GetRsenseConfig().stashGlowOption.RegisterEntity( this );
		SetFocusModeVisibility( FMV_Interactive ); // Without this initial focus mode is 'None'
	}
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Stash )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Stash ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().stashGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Stash ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
