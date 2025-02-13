// IMPORTANT: Both W3Door & W3NewDoor need support
// Why there are 2 door classes I don't know

/* ------------------------------ Option class ------------------------------ */

class CRsenseDoorHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'doorHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Door)entity || (W3NewDoor)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3Door ) protected function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().doorHighlightOption;
}
@addMethod( W3NewDoor ) protected function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().doorHighlightOption;
}
