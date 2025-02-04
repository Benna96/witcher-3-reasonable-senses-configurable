/* ------------------------------ Config class ------------------------------ */

class CRsenseConfig
{
	private var options : array< IRsenseOption >;
	public var applySettingsOption : CRsenseApplySettingsOption;
	public var herbGlowOption : CRsenseHerbGlowOption;
	public var containerGlowOption : CRsenseContainerGlowOption;

	public function Init()
	{
		var i : int;

		applySettingsOption = new CRsenseApplySettingsOption in this;
		herbGlowOption = new CRsenseHerbGlowOption in this;
		containerGlowOption = new CRsenseContainerGlowOption in this;

		options.PushBack( applySettingsOption );
		options.PushBack( herbGlowOption );
		options.PushBack( containerGlowOption );
		for( i = 0; i < options.Size(); i += 1 )
		{
			options[ i ].Init();
		}
	}

	public function GetAllOptions() : array< IRsenseOption >
	{
		return options;
	}
}

/* --------------------------------- Getter --------------------------------- */

@addField( CR4Game )
private var rsenseConfig : CRsenseConfig;
@addMethod( CR4Game ) public function GetRsenseConfig() : CRsenseConfig
{
	if( !rsenseConfig )
	{
		rsenseConfig = new CRsenseConfig in this;
		rsenseConfig.Init();
	}
	
	return rsenseConfig;
}
