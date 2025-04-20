/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'containerHighlight';

	protected final /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}
}

/* ------------------------------ Option access ----------------------------- */

// Override in specifically supported container classes
@addMethod( W3Container ) /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_CONTAINER;
}
