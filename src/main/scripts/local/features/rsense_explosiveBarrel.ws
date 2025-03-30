/* ------------------------------ Option class ------------------------------ */

class CRsenseExplosiveBarrelHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'explosiveBarrelHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (COilBarrelEntity)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( COilBarrelEntity ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_EXPLOSIVEBARREL;
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( COilBarrelEntity )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( COilBarrelEntity ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetHighlightOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( COilBarrelEntity ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
