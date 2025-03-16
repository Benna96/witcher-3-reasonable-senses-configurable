/* ------------------------------ Option class ------------------------------ */

class CRsenseStashHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'stashHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Stash)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3Stash ) protected function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().stashHighlightOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but stashes don't call super.OnSpawned
// In fact, stashes don't define OnSpawned at all, use InteractiveEntity instead
// Put this in its own class if I add more InteractiveEntity classes
@wrapMethod( CInteractiveEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
	return returnVal;
}
