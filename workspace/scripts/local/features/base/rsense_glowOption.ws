/* ----------------------- Base class for glow options ---------------------- */

abstract class IRsenseGlowOption extends IRsenseOption
{
	public var allowedVisibilities : int; // Flag version of EFocusModeVisibility, fmv has so few values that they work as flags as is
	protected var entities : array< CGameplayEntity >;

	protected /* override */ function OnValueChanged( newValue : string )
	{
		var option : string;

		allowedVisibilities = FMV_None;

		if( xmlType == "TOGGLE" )
		{
			allowedVisibilities |= FMV_Clue;
			if( newValue )
			{
				allowedVisibilities |= FMV_Interactive;
			}
		}

		else if( xmlType == "OPTIONS" )
		{
			option = config.GetVarOption( xmlGroup, xmlId, (int)newValue );
			if( option == "rsense_glow_UnexaminedOnly" || option == "rsense_glow_Always" )
			{
				allowedVisibilities |= FMV_Clue;
			}
			if( option == "rsense_glow_Always" )
			{
				allowedVisibilities |= FMV_Interactive;
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
		entity.SetFocusModeVisibility( entity.GetFocusModeVisibility() );
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

/* ----------------------- Glow option state handling ----------------------- */

@wrapMethod( CR4IngameMenu ) function LoadSaveRequested(saveSlotRef : SSavegameInfo) : void
{
	Rsense_ClearGlowOptionEntities();
	wrappedMethod( saveSlotRef ); 
}
@wrapMethod( CR4CommonMainMenuBase ) function OnConfigUI()
{
	// Doesn't matter much, cleared in LoadSave too
	// Just reduces unnecessary work when changing mod settings in main menu
	Rsense_ClearGlowOptionEntities();
	wrappedMethod();
}

function Rsense_ClearGlowOptionEntities()
{
	var options : array< IRsenseOption >;
	var i : int;

	options = theGame.GetRsenseConfig().GetAllOptions();
	for( i = 0; i < options.Size(); i += 1 )
	{
		if( (IRsenseGlowOption)options[ i ] )
			((IRsenseGlowOption)options[ i ]).ClearEntities();
	}
}
