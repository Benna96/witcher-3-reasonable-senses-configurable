/* ------------------------------ Option class ------------------------------ */

class CRsenseClueHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'clueHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3MonsterClue)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3MonsterClue ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_CLUE;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but clues don't call super.OnSpawned
@wrapMethod( W3MonsterClue ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
	return returnVal;
}
