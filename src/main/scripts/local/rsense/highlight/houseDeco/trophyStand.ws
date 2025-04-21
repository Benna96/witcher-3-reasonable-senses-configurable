/* ------------------------------ Option class ------------------------------ */

class CRsenseTrophyRackHighlightOption extends CRsenseGenericHouseDecoHighlightOption
{
	default xmlId = 'trophyStandHighlight';
	default defaultValue = "true";

	private var takeInventoryIntoAccount : bool;

	protected /* override */ function OnValueChanged( newValue : string )
	{
		super.OnValueChanged( newValue );

		if( newValue == "rsense_highlight_WhenEmpty" )
		{
			takeInventoryIntoAccount = true;
		}
		else
		{
			takeInventoryIntoAccount = false;
		}
	}

	public /* override */ function ModVisibility( entity : CGameplayEntity, focusModeVisibility : EFocusModeVisibility ) : EFocusModeVisibility
	{
		var inventory : CInventoryComponent;
		if( takeInventoryIntoAccount && ((W3HouseGenericDecoration)entity).HasTrophy() )
		{
			return FMV_None;
		}
		else
		{
			return super.ModVisibility( entity, focusModeVisibility );
		}
	}

	protected final /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return ((W3HouseGenericDecoration)entity).IsTrophyStand();
	}
}

/* -------------------------- Type identification --------------------------- */

@addMethod( W3HouseGenericDecoration ) protected final function IsTrophyStand() : bool
{
	if( GetTrophyStandType() != RSTT_NONE )
	{
		return true;
	}
	else
	{
		return false;
	}
}

enum ERsenseTrophyType
{
	RSTT_NONE,
	RSTT_OUTSIDEPEDESTAL,
	RSTT_BEDROOMSTAND
}

@addField( W3HouseGenericDecoration ) private var cachedTrophyType : ERsenseTrophyType;
@addField( W3HouseGenericDecoration ) private var trophyTypeIsCached : bool;
@addMethod( W3HouseGenericDecoration ) private final function GetTrophyStandType() : ERsenseTrophyType
{
	var template : CEntityTemplate;
	var appearances : array< name >;

	if( !trophyTypeIsCached )
	{
		template = (CEntityTemplate)LoadResource( GetReadableName(), true );
		GetAppearanceNames( template, appearances );

		if( appearances.Contains( 'reginalds_figurine' ) )
		{
			cachedTrophyType = RSTT_OUTSIDEPEDESTAL;
		}

		else if( appearances.Contains( 'q702_marlena_dowry' ) )
		{
			cachedTrophyType = RSTT_BEDROOMSTAND;
		}

		else
		{
			cachedTrophyType = RSTT_NONE;
		}

		trophyTypeIsCached = true;
	}

	return cachedTrophyType;
}

/* ------------------------------ Registration ------------------------------ */

@addMethod( W3HouseGenericDecoration ) protected final function FindLinkedTrophyEntities() : array< CGameplayEntity >
{
	var nearby : array< CGameplayEntity >;
	var linked : array< CGameplayEntity >;
	var i : int;

	switch( GetTrophyStandType() )
	{
		case RSTT_OUTSIDEPEDESTAL:
			FindGameplayEntitiesInRange( nearby, this, 0.1, 5 );
			for( i = 0; i < nearby.Size(); i += 1 )
			{
				if( nearby[ i ].GetParent().ToString() == "CLayer \"dlc\bob\data\levels\bob\quests\minor_quests\mq7024_home\entities\reginalds_figure\pedestal\entity.w2l\"" )
				{
					linked.PushBack( nearby[ i ] );
					break;
				}
			}
			break;
		
		case RSTT_BEDROOMSTAND:
			FindGameplayEntitiesInRange( nearby, this, 0.2, 5 );
			for( i = 0; i < nearby.Size(); i += 1 )
			{
				if( StrBeginsWith( nearby[ i ].GetParent().ToString(), "CLayer \"dlc\bob\data\levels\bob\locations\vineyards\east\corvo_bianco\mq7024_interior_deco\ground_floor_deco" ) )
				{
					linked.PushBack( nearby[ i ] );
					break;
				}
			}
			break;
	}

	return linked;
}

/* ---------------------------------- Data ---------------------------------- */

@addMethod( W3HouseGenericDecoration ) public final function HasTrophy() : bool
{
	return IsTrophyStand() && !inv.IsEmpty();
}
