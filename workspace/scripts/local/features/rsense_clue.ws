/* ------------------------------ Option class ------------------------------ */

class CRsenseClueGlowOption extends IRsenseGlowOption
{
	default xmlId = 'clueGlow';
	default defaultValue = "1";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3MonsterClue)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _mapPinEntities
@addMethod( W3MonsterClue ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().clueGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3MonsterClue ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}
