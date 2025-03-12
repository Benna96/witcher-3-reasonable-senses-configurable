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
	if( wrappedMethod( spawnData ) == true )
		return true;

	GetHighlightOption().RegisterEntity( this );
}

// Can't wrap SetFocusModeVisibility, sadly. Can't be done for imported functions.
// Add overrides for them in extending classes instead.
