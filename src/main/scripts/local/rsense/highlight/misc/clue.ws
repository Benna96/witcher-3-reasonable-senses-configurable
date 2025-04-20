/* ------------------------------ Option class ------------------------------ */

class CRsenseClueHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'clueHighlight';
	default defaultValue = "rsense_highlight_UnexaminedOnly";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3MonsterClue)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( W3MonsterClue ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_CLUE;
}

/* ------------------------------ Registration ------------------------------ */

// Duplicate, clues don't call super
@wrapMethod( W3MonsterClue ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
}
