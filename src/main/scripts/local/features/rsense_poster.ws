/* ------------------------------ Option class ------------------------------ */

class CRsensePosterHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'posterHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Poster)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

@addMethod( W3Poster ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_POSTER;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but posters don't call super.OnSpawned
@wrapMethod( W3Poster ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
	return returnVal;
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addMethod( W3Poster ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	focusModeVisibility = Rsense_CacheAndModVisibility( focusModeVisibility );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Poster ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_GetCachedOrActualVisibility( super.GetFocusModeVisibility() );
}
