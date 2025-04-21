/*                 | Shared house deco entity functionality |                 */
/*                 |________________________________________|                 */

/* ------------------------------ Option class ------------------------------ */

// Shared by trophy stand, ...
abstract class CRsenseGenericHouseDecoHighlightOption extends IRsenseHighlightOption
{
	public /* override */ function ApplyToEntity( entity : CGameplayEntity )
	{
		var visibilityToSet : EFocusModeVisibility;
		var linkedEntities : array< CGameplayEntity >;
		var i : int;

		super.ApplyToEntity( entity );

		visibilityToSet = ModVisibility( entity, entity.GetFocusModeVisibility() );
		linkedEntities = ((W3HouseGenericDecoration)entity).linkedEntities;
		for( i = 0; i < linkedEntities.Size(); i += 1 )
		{
			linkedEntities[ i ].SetFocusModeVisibility( visibilityToSet );
		}
	}

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3HouseGenericDecoration)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

// Duplicate, house decos don't call super
@wrapMethod( W3HouseGenericDecoration ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnValue : bool;

	returnValue = OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
	AddTimer( 'LinkEntitiesAndReapplyHighlight', 0 ); // Linked entities may not have spawned in yet
	return returnValue;
}

// Fetched once only
@addField( W3HouseGenericDecoration ) public var linkedEntities : array< CGameplayEntity >;
@addMethod( W3HouseGenericDecoration ) protected timer function LinkEntitiesAndReapplyHighlight( delta : float, id : int )
{
	if( IsTrophyStand() )
	{
		linkedEntities = FindLinkedTrophyEntities();
	}

	GetHighlightOption().ApplyToEntity( this );
}

/* --------------------------------- Hooks ---------------------------------- */

// These use timer because inventory doesn't get updated until ... a tick? later
@wrapMethod( W3Container ) function OnItemGiven(data : SItemChangedData)
{
	AddTimer( 'ReapplyHighlight', 0 );
	return wrappedMethod( data );	
}
@wrapMethod( W3Container ) function OnItemTaken(itemId : SItemUniqueId, quantity : int)
{
	AddTimer( 'ReapplyHighlight', 0 );
	return wrappedMethod( itemId, quantity );
}

// If there's need for this timer elsewhere, move it up to gameplay entity as a shared thing
@addMethod( W3Container ) timer function ReapplyHighlight( delta : float, id : int )
{
	GetHighlightOption().ApplyToEntity(this);
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
// Cache the value since it's not just a simple number now
@addField( W3HouseGenericDecoration ) private var cachedHighlightOptionIndex : int;
@addField( W3HouseGenericDecoration ) private var highlightOptionIndexIsCached: bool; // Would prefer init to -1
@addMethod( W3HouseGenericDecoration ) protected final /* override */ function GetHighlightOptionIndex() : int
{
	if( !highlightOptionIndexIsCached )
	{
		cachedHighlightOptionIndex = CalcHighlightOptionIndex();
		highlightOptionIndexIsCached = true;
	}

	return cachedHighlightOptionIndex;
}

@addMethod( W3HouseGenericDecoration ) protected /* override */ function CalcHighlightOptionIndex() : int
{
	if( IsTrophyStand() )
	{
		return RSHO_TROPHYSTAND;
	}

	return super.GetHighlightOptionIndex();
}
