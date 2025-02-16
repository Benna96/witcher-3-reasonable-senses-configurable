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

// Used in _entities
@addMethod( CBeehiveEntity ) protected /* override */ function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().beehiveHighlightOption;
}
