/* ------------------------------ Option class ------------------------------ */

class CRsenseBeehiveHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'beehiveHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (CBeehiveEntity)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( CBeehiveEntity ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_BEEHIVE;
}
