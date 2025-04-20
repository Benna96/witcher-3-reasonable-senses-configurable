// IMPORTANT: Both W3Door & W3NewDoor need support
// Why there are 2 door classes I don't know

/* ------------------------------ Option class ------------------------------ */

class CRsenseDoorHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'doorHighlight';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Door)entity || (W3NewDoor)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( W3Door ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_DOOR;
}
@addMethod( W3NewDoor ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_DOOR;
}
