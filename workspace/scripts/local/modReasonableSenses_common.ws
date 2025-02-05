/* -------------------------- Visibility injection -------------------------- */

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
function Rsense_SuperOrCachedVisibility( superValue : EFocusModeVisibility, cachedValue : EFocusModeVisibility ) : EFocusModeVisibility
{
	// Ensure clue highlight is always returned, even if set through engine
	if( superValue == FMV_Clue )
	{
		return superValue;
	}

	else
	{
		return cachedValue;
	}
}
