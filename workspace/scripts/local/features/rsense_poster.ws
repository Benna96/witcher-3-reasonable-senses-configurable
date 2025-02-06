/* ------------------------------ Option class ------------------------------ */

class CRsensePosterGlowOption extends IRsenseGlowOption
{
	default xmlId = 'posterGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Poster)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Poster ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().posterGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Poster )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Poster ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().posterGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Poster ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
