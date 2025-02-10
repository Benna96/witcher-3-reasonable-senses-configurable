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

/* ------------------------------ Option getter ----------------------------- */

@addMethod( W3Poster ) protected function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().posterGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but posters don't call super.OnSpawned
@wrapMethod( W3Poster ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Poster )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Poster ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetGlowOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Poster ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
