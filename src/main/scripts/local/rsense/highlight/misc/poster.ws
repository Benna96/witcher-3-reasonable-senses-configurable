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

// Duplicate, posters don't call super
@wrapMethod( W3Poster ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
}

/* -------------------------- Visibility injection -------------------------- */

@addMethod( W3Poster ) final /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	focusModeVisibility = SaveAndModVisibility( focusModeVisibility );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Poster ) final /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return GetNonModdedVisibility( super.GetFocusModeVisibility() );
}
