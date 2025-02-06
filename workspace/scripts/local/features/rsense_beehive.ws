/* ------------------------------ Option class ------------------------------ */

class CRsenseBeehiveGlowOption extends IRsenseGlowOption
{
	default xmlId = 'beehiveGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (CBeehiveEntity)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _container, functionality done through there
@addMethod( CBeehiveEntity ) protected /* override */ function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().beehiveGlowOption;
}
