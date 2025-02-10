/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerGlowOption extends IRsenseGlowOption
{
	default xmlId = 'containerGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _lockableEntities
// Override in supported container classes
@addMethod( W3Container ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().containerGlowOption;
}
