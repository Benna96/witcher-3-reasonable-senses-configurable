/* ------------------------------ Option class ------------------------------ */

class CRsenseStashHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'stashHighlight';
	default defaultValue = "true";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Stash)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( W3Stash ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_STASH;
}

/* ------------------------------ Registration ------------------------------ */

// Duplicate, stashes don't call super
// In fact, stashes don't define OnSpawned at all, use InteractiveEntity instead
// Put this in its own class if I add more InteractiveEntity classes
@wrapMethod( CInteractiveEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
}
