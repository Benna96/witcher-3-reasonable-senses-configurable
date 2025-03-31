/* ------------------------------- Enum utils ------------------------------- */
/*                  Helper functions for dealing with enums.                  */

// This is really not needed, but using it makes it much more clear what's going on.
// Would really like to just call it HasFlag, but that risks conflict with other mods...
function RSense_HasFlag( value : int, flag : int ) : bool
{
	return ( value & flag ) > 0;
}