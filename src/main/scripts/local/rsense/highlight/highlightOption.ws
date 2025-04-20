/* ------------------------------ Option class ------------------------------ */

abstract class IRsenseHighlightOption extends IRsenseOption
{
	default xmlGroup = 'rsenseHighlight';

	public var shouldDisableHighlight : bool;
	protected var entities : array< CGameplayEntity >;

	protected /* override */ function OnValueChanged( newValue : string )
	{
		if( xmlType == "TOGGLE" )
		{
			shouldDisableHighlight = !((bool)newValue);
		}

		else if( xmlType == "OPTIONS" )
		{
			if( newValue == "rsense_highlight_Never" )
			{
				shouldDisableHighlight = true;
			}
			else
			{
				shouldDisableHighlight = false;
			}
		}

		else
		{
			LogChannel( 'ReasonableSenses', ToString() + ": Unsupported xmlType " + xmlType );
		}
	}

	public final function RegisterEntity( entity : CGameplayEntity )
	{
		if( EnsureSupportedEntity( entity ) )
		{
			entities.PushBack( entity );
			ApplyToEntity( entity );
		}
	}

	protected final /* override */ function Apply_Impl()
	{
		var i : int;

		for( i = 0; i < entities.Size(); i += 1 )
		{
			if( EnsureSupportedEntity( entities[ i ] ) )
			{
				ApplyToEntity( entities[ i ] );
			}
		}
	}

	protected function ApplyToEntity( entity : CGameplayEntity )
	{
		// Force true for full control. False is unreliable, with house deco in particular.
		entity.SetFocusModeVisibility( entity.GetFocusModeVisibility(),, true );
	}

	public function ModVisibility( entity : CGameplayEntity, focusModeVisibility : EFocusModeVisibility ) : EFocusModeVisibility
	{
		if( shouldDisableHighlight )
		{
			return FMV_None;
		}
		else
		{
			return focusModeVisibility;
		}
	}

	public final function ClearEntities()
	{
		entities.Clear();
	}

	protected final function EnsureSupportedEntity( entity : CGameplayEntity ) : bool // Using this instead of generics, don't want to write a bunch of code multiple times but do want some kind of safety...
	{
		var isSupported : bool;

		isSupported = IsSupportedEntity( entity );
		if( !isSupported)
		{
			LogChannel( 'ReasonableSenses', ToString() + ": Entity <<" + entity.ToString() + ">> is not supported" );
		}

		return isSupported;
	}

	protected function IsSupportedEntity( entity : CGameplayEntity ) : bool;
}

/* ----------------------- Highlight option state handling ----------------------- */

@wrapMethod( CR4IngameMenu ) function LoadSaveRequested(saveSlotRef : SSavegameInfo) : void
{
	Rsense_ClearHighlightOptionEntities();
	wrappedMethod( saveSlotRef ); 
}
@wrapMethod( CR4CommonMainMenuBase ) function OnConfigUI()
{
	// Doesn't matter much, cleared in LoadSave too
	// Just reduces unnecessary work when changing mod settings in main menu
	Rsense_ClearHighlightOptionEntities();
	return wrappedMethod();
}

function Rsense_ClearHighlightOptionEntities()
{
	var options : array< IRsenseOption >;
	var i : int;

	options = theGame.GetRsenseConfig().options;
	for( i = 0; i < options.Size(); i += 1 )
	{
		if( (IRsenseHighlightOption)options[ i ] )
			((IRsenseHighlightOption)options[ i ]).ClearEntities();
	}
}
