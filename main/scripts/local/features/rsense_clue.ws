/* ------------------------------ Option class ------------------------------ */

class CRsenseClueGlowOption extends IRsenseGlowOption
{
	default xmlId = 'clueGlow';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3MonsterClue)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3MonsterClue ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().clueGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but clues don't call super.OnSpawned
@wrapMethod( W3MonsterClue ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}
