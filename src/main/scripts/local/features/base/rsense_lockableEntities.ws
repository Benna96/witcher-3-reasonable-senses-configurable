/* ------------------ Shared lockable entity functionality ------------------ */
/*                         To reduce code duplication                         */

// Don't override in supported classes
// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addMethod( W3LockableEntity ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	focusModeVisibility = Rsense_CacheAndModVisibility( focusModeVisibility );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3LockableEntity ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_GetCachedOrActualVisibility( super.GetFocusModeVisibility() );
}
