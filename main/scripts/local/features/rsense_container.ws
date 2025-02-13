/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'containerHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _entities
// Override in supported container classes
@addMethod( W3Container ) protected /* override */ function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().containerHighlightOption;
}
