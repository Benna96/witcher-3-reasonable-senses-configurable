/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerGlowOption extends IRsenseGlowOption
{
	default xmlId = 'containerGlow';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
// Override in supported container classes
@addMethod( W3Container ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().containerGlowOption;
}
