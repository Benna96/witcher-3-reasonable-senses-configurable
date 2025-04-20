/* ------------------------------ Option class ------------------------------ */

class CRsenseCorpseHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'corpseHighlight';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ActorRemains)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( W3ActorRemains ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_CORPSE;
}
