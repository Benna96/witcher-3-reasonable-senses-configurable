// The affected class has 'Repair' in the name, but actually just buffs

/* ------------------------------ Option class ------------------------------ */

class CRsenseBuffStationHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'buffStationHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ItemRepairObject)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3ItemRepairObject ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_BUFFSTATION;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but buff stations don't call super.OnSpawned
@wrapMethod( W3ItemRepairObject ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
	return returnVal;
}
