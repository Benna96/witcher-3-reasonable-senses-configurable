/* ------------------- Shared map pin entity functionality ------------------ */
/*                         To reduce code duplication                         */

// Override in supported classes
@addMethod( CR4MapPinEntity ) protected function GetGlowOption() : IRsenseGlowOption
{
	return NULL;
}

// Don't override in supported classes
// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( CR4MapPinEntity )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( CR4MapPinEntity ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetGlowOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( CR4MapPinEntity ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
