/* ------------------------------ Option class ------------------------------ */

class CRsenseBookshelfHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'bookshelfHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Bookshelf)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

@addMethod( W3Bookshelf ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_BOOKSHELF;
}
