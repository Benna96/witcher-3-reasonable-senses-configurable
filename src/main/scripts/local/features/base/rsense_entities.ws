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
