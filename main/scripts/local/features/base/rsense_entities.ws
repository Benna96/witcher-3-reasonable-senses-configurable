/* ----------------------- Shared entity functionality ---------------------- */
/*                         To reduce code duplication                         */

// Override in supported classes
@addMethod( CGameplayEntity ) protected function GetGlowOption() : IRsenseGlowOption
{
	return NULL;
}

// Maybe override in supported classes
@wrapMethod( CGameplayEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}

// Can't wrap SetFocusModeVisibility, sadly. Can't be done for imported functions.
// Add overrides for them in extending classes instead.
