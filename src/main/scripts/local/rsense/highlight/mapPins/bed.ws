/* ------------------------------ Option class ------------------------------ */

class CRsenseBedHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'bedHighlight';
	default defaultValue = "rsense_highlight_WhenNotWellRested";

	private var takeBuffIntoAccount : bool;

	protected /* override */ function OnValueChanged( newValue : string )
	{
		super.OnValueChanged( newValue );

		if( newValue == "rsense_highlight_WhenNotWellRested" )
		{
			takeBuffIntoAccount = true;
		}
		else
		{
			takeBuffIntoAccount = false;
		}
	}

	public /* override */ function ModVisibility( entity : CGameplayEntity, focusModeVisibility : EFocusModeVisibility ) : EFocusModeVisibility
	{
		if( takeBuffIntoAccount && thePlayer.HasBuff( EET_WellRested ) )
		{
			return FMV_None;
		}
		else
		{
			return super.ModVisibility( entity, focusModeVisibility );
		}
	}

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3WitcherBed)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

@addMethod( W3WitcherBed ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_BED;
}

/* -------------------------- Player buff trigger --------------------------- */

@addField( W3EffectManager )
private var rsense_queueBedHighlightUpdate : bool;

@wrapMethod( W3EffectManager ) function Initialize( actor : CActor )
{
	wrappedMethod( actor );
	if( (W3PlayerWitcher)owner )
	{
		rsense_queueBedHighlightUpdate = true;
	}
}
@wrapMethod( W3EffectManager ) function OnLoad(own : CActor)
{
	wrappedMethod( own );
	if( (W3PlayerWitcher)owner )
	{
		rsense_queueBedHighlightUpdate = true;
	}
}
@wrapMethod( W3EffectManager ) function OnBuffAdded(effect : CBaseGameplayEffect)
{
	wrappedMethod( effect );
	if( (W3PlayerWitcher)owner )
	{
		rsense_queueBedHighlightUpdate = true;
	}
}
@wrapMethod( W3EffectManager ) function OnBuffRemoved()
{
	wrappedMethod();
	if( (W3PlayerWitcher)owner )
	{
		rsense_queueBedHighlightUpdate = true;
	}
}

// Called from actor; Adding a timer to actor was not reliable, this is
@wrapMethod( W3EffectManager) function PerformUpdate(deltaTime : float)
{
	var options : array< IRsenseOption >;

	wrappedMethod( deltaTime );

	if( rsense_queueBedHighlightUpdate )
	{
		rsense_queueBedHighlightUpdate = false;

		options = theGame.GetRsenseConfig().options;
		options[RSHO_BED].Apply();
	}
}

// Bugfix for vanilla bug of bed highlight disappearing after using, see GH-12
// CRITICAL: Supposed to be W3WitcherBedStateWakeUp, but that throws an error;
// Will need an update once that bug is fixed!
@wrapMethod( WakeUp ) function OnEnterState( prevStateName : name )
{
	var returnVal : bool;

	returnVal = wrappedMethod( prevStateName );

	if( (W3WitcherBed)parent )
	{
		parent.SetFocusModeVisibility( parent.GetFocusModeVisibility(),, true );
	}

	return returnVal;
}
