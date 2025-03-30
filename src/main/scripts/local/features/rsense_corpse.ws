/* ------------------------------ Option class ------------------------------ */

class CRsenseCorpseHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'corpseHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ActorRemains)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
@addMethod( W3ActorRemains ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_CORPSE;
}
