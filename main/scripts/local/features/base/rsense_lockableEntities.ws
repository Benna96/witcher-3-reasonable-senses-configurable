/* ------------------- Shared lockable entity functionality ------------------ */
/*                         To reduce code duplication                         */

// Override in supported classes
@addMethod( W3LockableEntity ) protected function GetGlowOption() : IRsenseGlowOption
{
	return NULL;
}

// Maybe override in supported classes
@wrapMethod( W3LockableEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}

// Don't override in supported classes
// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3LockableEntity )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3LockableEntity ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetGlowOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3LockableEntity ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
