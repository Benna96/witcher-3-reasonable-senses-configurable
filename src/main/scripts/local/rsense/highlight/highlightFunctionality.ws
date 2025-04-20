/*             | Shared highlight functionality for all entities |            */
/*             |_________________________________________________|            */

/* ----------------------------- Option access ------------------------------ */

@addMethod( CGameplayEntity ) protected final function GetHighlightOption() : IRsenseHighlightOption
{
	var index : int;
	var options : array< IRsenseOption >;

	index = GetHighlightOptionIndex();
	if( index == -1 )
	{
		return NULL;
	}
	else
	{
		options = theGame.GetRsenseConfig().options;
		return (IRsenseHighlightOption)options[index];
	}
}
// Override in supported classes
@addMethod( CGameplayEntity ) protected /* virtual */ function GetHighlightOptionIndex() : int
{
	return -1;
}

// Duplicate in supported classes if they replace this without calling super
@wrapMethod( CGameplayEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
}
@addMethod( CGameplayEntity ) protected final function OnSpawned_HighlightHook( wrappedValue : bool ) : bool
{
	GetHighlightOption().RegisterEntity( this );
	return wrappedValue;
}

/* ---------------------------- Visibility logic ---------------------------- */

// Helpers to call from extending classes, can't wrap Set & Get in this class
@addField( CGameplayEntity ) private var nonModdedVisibility : EFocusModeVisibility;
@addField( CGameplayEntity ) private var visibilityMaybeModded : bool; // Would prefer initializing saved to -1, not possible with just annotations
@addMethod( CGameplayEntity ) protected final function SaveAndModVisibility( visibility : EFocusModeVisibility ) : EFocusModeVisibility
{
	var option : IRsenseHighlightOption;

	nonModdedVisibility = visibility;
	visibilityMaybeModded = true;

	option = GetHighlightOption();
	if( option )
	{
		visibility = option.ModVisibility( this, visibility );
	}

	return visibility;
}
@addMethod( CGameplayEntity ) protected final function GetNonModdedVisibility( engineVisibility : EFocusModeVisibility ) : EFocusModeVisibility
{
	if( visibilityMaybeModded )
	{
		return nonModdedVisibility;
	}
	else
	{
		return engineVisibility;
	}
}

/* ------------- Visibility injection shared across categories -------------- */
/*      Note: Visibility injection depends on gameplayEntity.ws changes       */

// Shared by containers, misc/door, misc/clue, misc/stash
@addMethod( W3LockableEntity ) final /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	focusModeVisibility = SaveAndModVisibility( focusModeVisibility );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3LockableEntity ) final /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return GetNonModdedVisibility( super.GetFocusModeVisibility() );
}
