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

// Used for highlight functionality
@addMethod( COilBarrelEntity ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_EXPLOSIVEBARREL;
}

/* -------------------------- Visibility injection -------------------------- */

@addMethod( COilBarrelEntity ) final /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	focusModeVisibility = SaveAndModVisibility( focusModeVisibility );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( COilBarrelEntity ) final /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return GetNonModdedVisibility( super.GetFocusModeVisibility() );
}
