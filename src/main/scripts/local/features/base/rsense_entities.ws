/* ----------------------- Shared entity functionality ---------------------- */
/*                         To reduce code duplication                         */

// Override in supported classes
@addMethod( CGameplayEntity ) protected final function GetHighlightOption() : IRsenseHighlightOption
{
	var index : int;
	var options : array< IRsenseOption >;

	index = GetHighlightOptionIndex();
	if( index == -1 )
		return NULL;
	else
	{
		options = theGame.GetRsenseConfig().options;
		return (IRsenseHighlightOption)options[index];
	}
}
@addMethod( CGameplayEntity ) protected function GetHighlightOptionIndex() : int
{
	return -1;
}

// Maybe override in supported classes
@wrapMethod( CGameplayEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
	return returnVal;
}

// Can't wrap SetFocusModeVisibility, sadly. Can't be done for imported functions.
// Add overrides for them in extending classes instead.
// Can add some shared logic to be called by said extending classes, though.
@addField( CGameplayEntity )
private var rsense_visibilitySet : bool;
@addField( CGameplayEntity )
private var rsense_cachedVisibility : EFocusModeVisibility;
@addMethod( CGameplayEntity ) protected function Rsense_CacheAndModVisibility( focusModeVisibility : EFocusModeVisibility ) : EFocusModeVisibility
{
	var option : IRsenseHighlightOption;

	rsense_visibilitySet = true;
	rsense_cachedVisibility = focusModeVisibility;

	option = GetHighlightOption();
	if( option )
	{
		focusModeVisibility = option.ModVisibility( focusModeVisibility );
	}

	return focusModeVisibility;
}
@addMethod( CGameplayEntity ) protected function Rsense_GetCachedOrActualVisibility( actual : EFocusModeVisibility ) : EFocusModeVisibility
{
	if( rsense_visibilitySet )
	{
		return rsense_cachedVisibility;
	}
	else
	{
		return actual;
	}
}
