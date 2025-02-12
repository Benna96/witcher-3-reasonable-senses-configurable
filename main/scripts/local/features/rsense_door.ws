// IMPORTANT: Both W3Door & W3NewDoor need support
// Why there are 2 door classes I don't know

/* ------------------------------ Option class ------------------------------ */

class CRsenseDoorGlowOption extends IRsenseGlowOption
{
	default xmlId = 'doorGlow';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Door)entity || (W3NewDoor)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3Door ) protected function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().doorGlowOption;
}
@addMethod( W3NewDoor ) protected function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().doorGlowOption;
}
