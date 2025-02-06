/* ------------------------------ Option class ------------------------------ */

class CRsenseCorpseGlowOption extends IRsenseGlowOption
{
	default xmlId = 'corpseGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ActorRemains)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _container, functionality done through there
@addMethod( W3ActorRemains ) protected /* override */ function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().corpseGlowOption;
}
