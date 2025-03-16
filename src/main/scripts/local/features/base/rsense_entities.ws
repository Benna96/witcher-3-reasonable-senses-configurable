/* ----------------------- Shared entity functionality ---------------------- */
/*                         To reduce code duplication                         */

// Override in supported classes
@addMethod( CGameplayEntity ) protected function GetHighlightOption() : IRsenseHighlightOption
{
	return NULL;
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
