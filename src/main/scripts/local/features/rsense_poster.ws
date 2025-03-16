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

@addMethod( W3Poster ) protected function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().posterHighlightOption;
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
@addField( W3Poster )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Poster ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetHighlightOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Poster ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
