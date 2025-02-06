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

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3ActorRemains ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().corpseGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Used in _container
// Helper func needed because various container classes have their own options
@addMethod( W3ActorRemains ) protected /* override */ function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().corpseGlowOption;
}
