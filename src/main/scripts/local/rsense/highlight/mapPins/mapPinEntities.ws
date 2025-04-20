/*                   | Shared map pin entity functionality |                  */
/*                   |_____________________________________|                  */

/* -------------------------- Visibility injection -------------------------- */

@addMethod( CR4MapPinEntity ) final /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	focusModeVisibility = SaveAndModVisibility( focusModeVisibility );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( CR4MapPinEntity ) final /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return GetNonModdedVisibility( super.GetFocusModeVisibility() );
}
