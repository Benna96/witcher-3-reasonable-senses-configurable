// The affected class has 'Repair' in the name, but actually just buffs

/* ------------------------------ Option class ------------------------------ */

class CRsenseBuffStationGlowOption extends IRsenseGlowOption
{
	default xmlId = 'buffStationGlow';
	default defaultValue = "true";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ItemRepairObject)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3ItemRepairObject ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().buffStationGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but buff stations don't call super.OnSpawned
@wrapMethod( W3ItemRepairObject ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}
