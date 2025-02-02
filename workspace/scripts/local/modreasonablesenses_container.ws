/* ------------------------------- Mod values ------------------------------- */
/*              Getters make overriding easiest & ensure defaults             */

@addMethod( W3Container ) public function GetInteractiveFocusModeVisibility() : EFocusModeVisibility
{
	return FMV_Interactive;
}

@addMethod( W3Container ) public function GetFoliageFullEntry() : name
{
	return 'full';
}

/* ---------------------- FocusModeVisibility overrides --------------------- */
/*                        Depends on gamePlayEntity.ws                        */

@addField( W3Container )
private var cachedFocusModeVisiblity : EFocusModeVisibility;

@addMethod( W3Container ) function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	if( focusModeVisibility == FMV_Interactive )
	{
		super.SetFocusModeVisibility( GetInteractiveFocusModeVisibility(), persistent, force );
	}
	else
	{
		super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
	}
}

@addMethod( W3Container ) function GetFocusModeVisibility() : EFocusModeVisibility
{
	var superValue : EFocusModeVisibility;

	superValue = super.GetFocusModeVisibility();

	// Ensure clue highlight is always returned, even if set through engine
	if( superValue == FMV_Clue )
	{
		return superValue;
	}
	
	else
	{
		return cachedFocusModeVisiblity;
	}
}

/* ------------------------ SetAndSaveEntry override ------------------------ */

@wrapMethod( CSwitchableFoliageComponent ) function SetAndSaveEntry( entryName : name )
{
	var container : W3Container;

	if( entryName == 'full' )
	{
		container = (W3Container)GetEntity();
		if( container )
		{
			entryName = container.GetFoliageFullEntry();
		}
	}

	wrappedMethod( entryName );
}