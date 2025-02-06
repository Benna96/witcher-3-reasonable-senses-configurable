/* ------------------------------ Config class ------------------------------ */

class CRsenseConfig
{
	private var options : array< IRsenseOption >;
	public var applySettingsOption : CRsenseApplySettingsOption;
	public var signpostGlowOption : CRsenseSignpostGlowOption;
	public var posterGlowOption : CRsensePosterGlowOption;
	public var herbGlowOption : CRsenseHerbGlowOption;
	public var beehiveGlowOption : CRsenseBeehiveGlowOption;
	public var containerGlowOption : CRsenseContainerGlowOption;
	public var doorGlowOption : CRsenseDoorGlowOption;
	public var corpseGlowOption : CRsenseCorpseGlowOption;

	public function Init()
	{
		var i : int;

		applySettingsOption = new CRsenseApplySettingsOption in this;
		signpostGlowOption = new CRsenseSignpostGlowOption in this;
		posterGlowOption = new CRsensePosterGlowOption in this;
		herbGlowOption = new CRsenseHerbGlowOption in this;
		beehiveGlowOption = new CRsenseBeehiveGlowOption in this;
		containerGlowOption = new CRsenseContainerGlowOption in this;
		doorGlowOption = new CRsenseDoorGlowOption in this;
		corpseGlowOption = new CRsenseCorpseGlowOption in this;

		options.PushBack( applySettingsOption );
		options.PushBack( signpostGlowOption );
		options.PushBack( posterGlowOption );
		options.PushBack( herbGlowOption );
		options.PushBack( beehiveGlowOption );
		options.PushBack( containerGlowOption );
		options.PushBack( doorGlowOption );
		options.PushBack( corpseGlowOption );
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
