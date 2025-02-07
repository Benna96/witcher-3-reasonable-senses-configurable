/* ---------------------------- Visibility utils ---------------------------- */
/* Shared functionality to be called from elsewhere to reduce code duplication */

// Call from SetFocusModeVisibility override
function Rsense_MaybeNoVisibility( focusModeVisibility : EFocusModeVisibility, option : IRsenseGlowOption ) : EFocusModeVisibility
{
	if( focusModeVisibility == FMV_Interactive && !option.currentValue )
	{
		return FMV_None;
	}
	else
	{
		return focusModeVisibility;
	}
}

// Call from GetFocusModeVisibility override
function Rsense_SuperOrCachedVisibility( superValue : EFocusModeVisibility, cachedValue : EFocusModeVisibility ) : EFocusModeVisibility
{
	// Mod logic may override visibility to None, but never others.
	if( superValue == FMV_None )
	{
		return cachedValue;
	}
	else
	{
		return superValue;
	}
}
