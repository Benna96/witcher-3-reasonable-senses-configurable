// The affected class has 'Repair' in the name, but actually just buffs

/* ------------------------------ Option class ------------------------------ */

class CRsenseBuffStationHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'buffStationHighlight';
	default defaultValue = "true";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ItemRepairObject)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( W3ItemRepairObject ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_BUFFSTATION;
}

/* ------------------------------ Registration ------------------------------ */

// Duplicate, buff stations don't call super
@wrapMethod( W3ItemRepairObject ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
}
