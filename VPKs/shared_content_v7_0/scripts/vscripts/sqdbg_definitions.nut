
local format = format;
local tmp = { name = null }

foreach ( key, val in this )
{
	if ( typeof val == "class" )
	{
		tmp.name = key;
		sqdbg_define_class( val, tmp );
	}
}

local GetNetPropString = function( key      ) { return ::NetProps.GetPropString( this, key      ); }
local SetNetPropString = function( key, val ) { return ::NetProps.SetPropString( this, key, val ); }
local GetNetPropInt    = function( key      ) { return ::NetProps.GetPropInt   ( this, key      ); }
local SetNetPropInt    = function( key, val ) { return ::NetProps.SetPropInt   ( this, key, val ); }
local GetNetPropFloat  = function( key      ) { return ::NetProps.GetPropFloat ( this, key      ); }
local SetNetPropFloat  = function( key, val ) { return ::NetProps.SetPropFloat ( this, key, val ); }
local GetNetPropVector = function( key      ) { return ::NetProps.GetPropVector( this, key      ); }
local SetNetPropVector = function( key, val ) { return ::NetProps.SetPropVector( this, key, val ); }
local GetNetPropEntity = function( key      ) { return ::NetProps.GetPropEntity( this, key      ); }
local SetNetPropEntity = function( key, val ) { return ::NetProps.SetPropEntity( this, key, val ); }

local CArrayAccessor = class
{
	// Implementation note:
	// Native array elements are going to be listed as custom members of this accessor class.
	// Indicate to the debugger that this class is going to have non-string
	// members by having existing member names to be escaped
	// so that custom number members are evaluated as numbers.
	["members\0"] = null;
	count = 0;
	type = "";
	ent = null;
	key = null;
	iget = null;
	iset = null;

	constructor ( ent, key, type, count = 0 )
	{
		this.ent = ent;
		this.key = key;
		this.type = type;
		local maxcount = ::NetProps.GetPropArraySize( ent, key );
		if ( count < maxcount )
			count = maxcount;
		this.count = count;
		iget = format("GetProp%sArray", type);
		iset = format("SetProp%sArray", type);
		local arr = this["members\0"] = ::array( count );
		foreach ( i, v in arr )
			arr[i] = { name = i, get = get, set = set };
	}

	get = function( i    ) { return ::NetProps[iget]( ent, key, i    ); }
	set = function( i, v ) { return ::NetProps[iset]( ent, key, v, i ); }
}

CArrayAccessor._get <- CArrayAccessor.get;
CArrayAccessor._set <- CArrayAccessor.set;

sqdbg_define_class( CArrayAccessor,
{
	name = "CArrayAccessor",
	value = function() { return format("%s[%d]", type, count); },
	custommembers = function() { return this["members\0"]; },
} );

local GetNetPropEntityArray = function( key ) { return CArrayAccessor( this, key, "Entity" ); }

if ( SERVER_DLL )
{
	local baseentity_custommembers =
	[
		{ name = "m_vecOrigin", get = GetNetPropVector, set = SetNetPropVector },
		// To be able to add data breakpoints on Vector or array elements,
		// define indices as members
		/*
		{
			name = "m_vecOrigin[2]",
			get = function() { return ::NetProps.GetPropFloatArray( this, "m_vecOrigin", 2 ); },
			set = function( val ) { return ::NetProps.SetPropFloatArray( this, "m_vecOrigin", val, 2 ); }
		},
		*/
		{ name = "m_angRotation", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecAbsOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_angAbsRotation", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecBaseVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecAbsVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecAngVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecViewOffset", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_nModelIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iTextureFrameIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nRenderMode", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nRenderFX", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_fEffects", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_fFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iEFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_clrRender", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iViewHideFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iTeamNum", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iHealth", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iMaxHealth", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_target", get = GetNetPropString, set = SetNetPropString },
		{ name = "m_CollisionGroup", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flElasticity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flFriction", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flGravity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flShadowCastDistance", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flDesiredShadowCastDistance", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_hOwnerEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hEffectEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hMoveParent", get = GetNetPropEntity },
		{ name = "m_iParentAttachment", get = GetNetPropInt },
		{ name = "m_pPhysicsObject", get = GetNetPropEntity },
		{ name = "m_MoveType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_MoveCollide", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nWaterLevel", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nWaterType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_vecMinsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecMaxsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecMins", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecMaxs", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_nSolidType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_usSolidFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_nSurroundType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_flRadius", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Collision.m_triggerBloat", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_vecSurroundingMins", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSurroundingMaxs", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMinsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMaxsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMins", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMaxs", get = GetNetPropVector, set = SetNetPropVector },
	];

	local baseanimating_custommembers = (clone baseentity_custommembers).extend(
	[
		{ name = "m_flGroundSpeed", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flLastEventCheck", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_nSequence", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bSequenceFinished", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bSequenceLoops", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nSkin", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nBody", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flModelScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flPlaybackRate", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flCycle", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_hLightingOrigin", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hLightingOriginRelative", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_flFadeScale", get = GetNetPropFloat, set = SetNetPropFloat },
	]);

	local basecombatcharacter_custommembers = (clone baseanimating_custommembers).extend(
	[
		{ name = "m_flNextAttack", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flFieldOfView", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_LastHitGroup", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flDamageAccumulator", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_CurrentWeaponProficiency", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_hActiveWeapon", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_bPreventWeaponPickup", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_hMyWeapons", get = GetNetPropEntityArray },
	]);

	local player_custommembers = (clone basecombatcharacter_custommembers).extend(
	[
		{ name = "m_hLastWeapon", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_nImpulse", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nButtons", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonLast", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonPressed", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonReleased", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonDisabled", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonForced", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flStepSoundTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flSwimSoundTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_iFOV", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iFOVStart", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flFOVTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_iDefaultFOV", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flVehicleViewFOV", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_hZoomOwner", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hVehicle", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hUseEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_flForwardMove", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flSideMove", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flMaxspeed", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flWaterJumpTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_vecWaterJumpVel", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_nDrownDmgRate", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bitsDamageType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bPlayerUnderwater", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flSwimTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_bDuckToggled", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flDuckTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flDuckJumpTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_idrowndmg", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_idrownrestored", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nPoisonDmg", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nPoisonRestored", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bitsHUDDamage", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_fInitHUD", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flDeathTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flDeathAnimTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_iFrags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iDeaths", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bAllowInstantSpawn", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flNextDecalTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_ArmorValue", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_DmgOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_DmgTake", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_DmgSave", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_AirFinished", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_PainFinished", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_bInTriggerFall", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_bDrawPlayerModelExternally", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iPlayerLocked", get = GetNetPropInt, set = SetNetPropInt },
		{
			name = "m_hViewModel[0]",
			get = function() { return ::NetProps.GetPropEntityArray( this, "m_hViewModel", 0 ); },
			set = function(v) { return ::NetProps.SetPropEntityArray( this, "m_hViewModel", v, 0 ); },
		},
		{
			name = "m_hViewModel[1]",
			get = function() { return ::NetProps.GetPropEntityArray( this, "m_hViewModel", 1 ); },
			set = function(v) { return ::NetProps.SetPropEntityArray( this, "m_hViewModel", v, 1 ); },
		},
		{ name = "m_hPostProcessCtrl", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hColorCorrectionCtrl", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hLocatorTargetEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "pl.v_angle", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_iHideHUD", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_flFOVRate", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_bDucked", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bDucking", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bInDuckJump", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_flDucktime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_flDuckJumpTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_flJumpTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_flFallVelocity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_nOldButtons", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_vecPunchAngle", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_vecPunchAngleVel", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_bDrawViewmodel", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bWearingSuit", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bPoisoned", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_flStepSize", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_bAllowAutoMovement", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.scale", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.origin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_skybox3d.angles", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_skybox3d.skycamera", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_Local.m_skybox3d.skycolor", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.area", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.enable", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.blend", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.dirPrimary", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_skybox3d.fog.colorPrimary", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.colorSecondary", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.start", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_skybox3d.fog.end", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_skybox3d.fog.maxdensity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_skybox3d.fog.farz", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_PlayerFog.m_hCtrl", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_Local.m_PlayerFog.m_flTransitionTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_PlayerFog.m_OldColor", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_PlayerFog.m_flOldStart", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_PlayerFog.m_flOldEnd", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_PlayerFog.m_NewColor", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_PlayerFog.m_flNewStart", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_PlayerFog.m_flNewEnd", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_fog.enable", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_fog.blend", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_fog.dirPrimary", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_fog.colorPrimary", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_fog.colorSecondary", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_fog.start", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_fog.end", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_fog.farz", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_fog.maxdensity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flTonemapScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flTonemapRate", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flBloomScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flAutoExposureMin", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flAutoExposureMax", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_audio.localSound[0]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[1]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[2]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[3]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[4]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[5]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[6]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[7]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.soundscapeIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_audio.localBits", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_audio.ent", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_flSuitPower", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_HL2Local.m_bZooming", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bitsActiveDevices", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_iSquadMemberCount", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_iSquadMedicCount", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_fSquadInFollowMode", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bWeaponLowered", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_hAutoAimTarget", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_vecAutoAimPoint", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_HL2Local.m_hLadder", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_bDisplayReticle", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bStickyAutoAim", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bAutoAimTarget", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_flFlashBattery", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_HL2Local.m_vecLocatorOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_HL2Local.m_LadderMove.m_bForceLadderMove", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_LadderMove.m_bForceMount", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_LadderMove.m_flStartTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_HL2Local.m_LadderMove.m_flArrivalTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_HL2Local.m_LadderMove.m_vecStartPosition", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_HL2Local.m_LadderMove.m_vecGoalPosition", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_HL2Local.m_LadderMove.m_hForceLadder", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_LadderMove.m_hReservedSpot", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_bSprintEnabled", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_fIsSprinting", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_fIsWalking", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flSuitPowerLoad", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_bFlashlightDisabled", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_LowerWeaponTimer.m_next", get = GetNetPropFloat, set = SetNetPropFloat },
	]);

	local basecombatweapon_custommembers = (clone baseanimating_custommembers).extend(
	[
		{ name = "m_iViewModelIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "LocalActiveWeaponData.m_flNextPrimaryAttack", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "LocalActiveWeaponData.m_flNextSecondaryAttack", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "LocalActiveWeaponData.m_flTimeWeaponIdle", get = GetNetPropFloat, set = SetNetPropFloat },
	]);

	sqdbg_define_class( CBaseEntity,
	{
		value = CBaseEntity.tostring,
		custommembers = baseentity_custommembers
	} );

	sqdbg_define_class( CBaseAnimating,
	{
		custommembers = baseanimating_custommembers
	} );

	sqdbg_define_class( CBaseCombatCharacter,
	{
		custommembers = baseanimating_custommembers
	} );

	sqdbg_define_class( CBasePlayer,
	{
		custommembers = player_custommembers
	} );

	sqdbg_define_class( CBaseCombatWeapon,
	{
		custommembers = basecombatweapon_custommembers
	} );

	sqdbg_define_class( IPhysicsObject,
	{
		value = IPhysicsObject.GetName,
		custommembers =
		[
			{ name = "inertia", get = IPhysicsObject.GetInertia, set = IPhysicsObject.SetInertia },
			{ name = "isAsleep", get = IPhysicsObject.IsAsleep, set = function(i) { if (i) return Sleep(); return Wake(); } },
			{ name = "isCollisionEnabled", get = IPhysicsObject.IsCollisionEnabled, set = IPhysicsObject.EnableCollisions },
			{ name = "isDragEnabled", get = IPhysicsObject.IsDragEnabled, set = IPhysicsObject.EnableDrag },
			{ name = "isFluid", get = IPhysicsObject.IsFluid },
			{ name = "isGravityEnabled", get = IPhysicsObject.IsGravityEnabled, set = IPhysicsObject.EnableGravity },
			{ name = "isHinged", get = IPhysicsObject.IsHinged },
			{ name = "isMotionEnabled", get = IPhysicsObject.IsMotionEnabled, set = IPhysicsObject.EnableMotion },
			{ name = "isStatic", get = IPhysicsObject.IsStatic },
			{ name = "isTrigger", get = IPhysicsObject.IsTrigger },
			{ name = "mass", get = IPhysicsObject.GetMass, set = IPhysicsObject.SetMass },
		]
	} );

	sqdbg_define_class( AI_EnemyInfo_t,
	{
		value = function() { return "enemy = " + Enemy(); },
		custommembers =
		[
			{ name = "vLastKnownLocation", get = AI_EnemyInfo_t.LastKnownLocation, set = AI_EnemyInfo_t.SetLastKnownLocation },
			{ name = "vLastSeenLocation", get = AI_EnemyInfo_t.LastSeenLocation, set = AI_EnemyInfo_t.SetLastSeenLocation },
			{ name = "timeLastSeen", get = AI_EnemyInfo_t.TimeLastSeen, set = AI_EnemyInfo_t.SetTimeLastSeen },
			{ name = "timeFirstSeen", get = AI_EnemyInfo_t.TimeFirstSeen, set = AI_EnemyInfo_t.SetTimeFirstSeen },
			{ name = "timeLastReacquired", get = AI_EnemyInfo_t.TimeLastReacquired, set = AI_EnemyInfo_t.SetTimeLastReacquired },
			{ name = "timeValidEnemy", get = AI_EnemyInfo_t.TimeValidEnemy, set = AI_EnemyInfo_t.SetTimeValidEnemy },
			{ name = "timeLastReceivedDamageFrom", get = AI_EnemyInfo_t.TimeLastReceivedDamageFrom, set = AI_EnemyInfo_t.SetTimeLastReceivedDamageFrom },
			{ name = "timeAtFirstHand", get = AI_EnemyInfo_t.TimeAtFirstHand, set = AI_EnemyInfo_t.SetTimeAtFirstHand },
			{ name = "bDangerMemory", get = AI_EnemyInfo_t.DangerMemory, set = AI_EnemyInfo_t.SetDangerMemory },
			{ name = "bEludedMe", get = AI_EnemyInfo_t.EludedMe, set = AI_EnemyInfo_t.SetEludedMe },
			{ name = "bUnforgettable", get = AI_EnemyInfo_t.Unforgettable, set = AI_EnemyInfo_t.SetUnforgettable },
			{ name = "bMobbedMe", get = AI_EnemyInfo_t.MobbedMe, set = AI_EnemyInfo_t.SetMobbedMe },
		]
	} );

	sqdbg_define_class( CUserCmd,
	{
		value = function() { return "command_number = " + GetCommandNumber(); }
		custommembers =
		[
			{ name = "command_number", get = CUserCmd.GetCommandNumber },
			{ name = "tick_count", get = CUserCmd.GetTickCount },
			{ name = "viewangles", get = CUserCmd.GetViewAngles, set = CUserCmd.SetViewAngles },
			{ name = "forwardmove", get = CUserCmd.GetForwardMove, set = CUserCmd.SetForwardMove },
			{ name = "sidemove", get = CUserCmd.GetSideMove, set = CUserCmd.SetSideMove },
			{ name = "upmove", get = CUserCmd.GetUpMove, set = CUserCmd.SetUpMove },
			{ name = "buttons", get = CUserCmd.GetButtons, set = CUserCmd.SetButtons },
			{ name = "impulse", get = CUserCmd.GetImpulse, set = CUserCmd.SetImpulse },
			{ name = "weaponselect", get = CUserCmd.GetWeaponSelect, set = CUserCmd.SetWeaponSelect },
			{ name = "weaponsubtype", get = CUserCmd.GetWeaponSubtype, set = CUserCmd.SetWeaponSubtype },
			{ name = "random_seed", get = CUserCmd.GetRandomSeed },
			{ name = "mousedx", get = CUserCmd.GetMouseX, set = CUserCmd.SetMouseX },
			{ name = "mousedy", get = CUserCmd.GetMouseY, set = CUserCmd.SetMouseY },
		]
	} );
}
else if ( CLIENT_DLL )
{
	local baseentity_custommembers =
	[
		{ name = "m_vecOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_angRotation", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecAbsOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_angAbsRotation", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecBaseVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecAbsVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecAngVelocity", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecNetworkOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_angNetworkAngles", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_vecViewOffset", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_nModelIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iTextureFrameIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nRenderMode", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nRenderFX", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_fEffects", get = C_BaseEntity.GetEffects, set = C_BaseEntity.SetEffects },
		{ name = "m_fFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iEFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_clrRender", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iViewHideFlags", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iTeamNum", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_CollisionGroup", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flElasticity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flFriction", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flGravity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flShadowCastDistance", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_hOwnerEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hEffectEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hMoveParent", get = C_BaseEntity.GetMoveParent },
		{ name = "m_hNetworkMoveParent", get = GetNetPropEntity },
		{ name = "m_iParentAttachment", get = GetNetPropInt },
		{ name = "m_MoveType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_MoveCollide", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nWaterLevel", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nWaterType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_vecMinsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecMaxsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecMins", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecMaxs", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_nSolidType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_usSolidFlags", get = GetNetPropInt, set = SetNetPropInt },
		//{ name = "m_Collision.m_nSurroundType", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_triggerBloat", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMinsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMaxsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMins", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMaxs", get = GetNetPropVector, set = SetNetPropVector },
	];

	local baseanimating_custommembers = (clone baseentity_custommembers).extend(
	[
		{ name = "m_nSequence", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nSkin", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nBody", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flModelScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flModelWidthScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flPlaybackRate", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flCycle", get = GetNetPropFloat, set = SetNetPropFloat },
	]);

	local basecombatcharacter_custommembers = (clone baseanimating_custommembers).extend(
	[
		{ name = "m_flNextAttack", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_hActiveWeapon", get = GetNetPropEntity, set = SetNetPropEntity },
	]);

	local player_custommembers = (clone basecombatcharacter_custommembers).extend(
	[
		{ name = "m_hLastWeapon", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_iHealth", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nImpulse", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_nButtons", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonLast", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonPressed", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_afButtonReleased", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flStepSoundTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flSwimSoundTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_surfaceFriction", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_iFOV", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_iFOVStart", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_flFOVTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_iDefaultFOV", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_hZoomOwner", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hVehicle", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hUseEntity", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_flMaxspeed", get = GetNetPropFloat, set = SetNetPropFloat },
		{
			name = "m_hViewModel[0]",
			get = function() { return ::NetProps.GetPropEntityArray( this, "m_hViewModel", 0 ); },
			set = function(v) { return ::NetProps.SetPropEntityArray( this, "m_hViewModel", v, 0 ); },
		},
		{
			name = "m_hViewModel[1]",
			get = function() { return ::NetProps.GetPropEntityArray( this, "m_hViewModel", 1 ); },
			set = function(v) { return ::NetProps.SetPropEntityArray( this, "m_hViewModel", v, 1 ); },
		},
		{ name = "m_hPostProcessCtrl", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_hColorCorrectionCtrl", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_Local.m_iHideHUD", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_flFOVRate", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_bDucked", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bDucking", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bInDuckJump", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_flDucktime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_flDuckJumpTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_flJumpTime", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_flFallVelocity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_vecPunchAngle", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_vecPunchAngleVel", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_bDrawViewmodel", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bWearingSuit", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_bPoisoned", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_flStepSize", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_bAllowAutoMovement", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.scale", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.origin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_skybox3d.angles", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_skybox3d.skycamera", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_Local.m_skybox3d.skycolor", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.area", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.enable", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.blend", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.dirPrimary", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_skybox3d.fog.colorPrimary", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.colorSecondary", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_skybox3d.fog.start", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_skybox3d.fog.end", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_skybox3d.fog.maxdensity", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_skybox3d.fog.farz", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_PlayerFog.m_hCtrl", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_Local.m_TonemapParams.m_flTonemapScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flTonemapRate", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flBloomScale", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flAutoExposureMin", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_TonemapParams.m_flAutoExposureMax", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_Local.m_audio.localSound[0]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[1]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[2]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[3]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[4]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[5]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[6]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.localSound[7]", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Local.m_audio.soundscapeIndex", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_audio.localBits", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Local.m_audio.ent", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_flSuitPower", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_HL2Local.m_bZooming", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bitsActiveDevices", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_iSquadMemberCount", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_iSquadMedicCount", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_fSquadInFollowMode", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bWeaponLowered", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_hAutoAimTarget", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_vecAutoAimPoint", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_HL2Local.m_hLadder", get = GetNetPropEntity, set = SetNetPropEntity },
		{ name = "m_HL2Local.m_bDisplayReticle", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bStickyAutoAim", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_bAutoAimTarget", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_HL2Local.m_flFlashBattery", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_HL2Local.m_vecLocatorOrigin", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_fIsSprinting", get = GetNetPropInt, set = SetNetPropInt },
	]);

	sqdbg_define_class( C_BaseEntity,
	{
		value = C_BaseEntity.tostring,
		custommembers = baseentity_custommembers
	} );

	sqdbg_define_class( C_BaseAnimating,
	{
		custommembers = baseanimating_custommembers
	} );

	sqdbg_define_class( C_BaseCombatCharacter,
	{
		custommembers = function()
		{
			if ( IsPlayer() )
				return player_custommembers;
			return baseanimating_custommembers;
		}
	} );

	sqdbg_define_class( IScriptVGUIObject,
	{
		value = function()
		{
			return format( "(%s) %d %d %d %d", GetName(), GetXPos(), GetYPos(), GetWide(), GetTall() );
		}
	} );
}

sqdbg_define_class( Vector,
{
	value = function()
	{
		local FLT_MAX = 3.40282347e+38;
		if ( x == FLT_MAX && y == FLT_MAX && z == FLT_MAX )
			return "vec3_invalid";
		return ToKVString();
	},
	metamembers = [ "x", "y", "z" ]
} );

sqdbg_define_class( CGameTrace,
{
	name = "trace_t",
	value = function()
	{
		local ent = Entity();
		if ( ent )
			return format( "%f, %s", Fraction(), ""+ent );
		return format( "%f", Fraction() );
	},
	custommembers =
	[
		{ name = "allsolid", get = CGameTrace.AllSolid },
		{ name = "contents", get = CGameTrace.Contents },
		{ name = "dispFlags", get = CGameTrace.DispFlags },
		{ name = "entity", get = CGameTrace.Entity },
		{ name = "fraction", get = CGameTrace.Fraction },
		{ name = "plane", get = CGameTrace.Plane },
		{ name = "startsolid", get = CGameTrace.StartSolid },
		{ name = "surface", get = CGameTrace.Surface },
	]
} );

sqdbg_define_class( CTakeDamageInfo,
{
	value = function() { return "m_flDamage = " + GetDamage(); },
	custommembers =
	[
		{ name = "m_vecDamageForce", get = CTakeDamageInfo.GetDamageForce, set = CTakeDamageInfo.SetDamageForce },
		{ name = "m_vecDamagePosition", get = CTakeDamageInfo.GetDamagePosition, set = CTakeDamageInfo.SetDamagePosition },
		{ name = "m_vecReportedPosition", get = CTakeDamageInfo.GetReportedPosition, set = CTakeDamageInfo.SetReportedPosition },
		{ name = "m_hInflictor", get = CTakeDamageInfo.GetInflictor, set = CTakeDamageInfo.SetInflictor },
		{ name = "m_hAttacker", get = CTakeDamageInfo.GetAttacker, set = CTakeDamageInfo.SetAttacker },
		{ name = "m_hWeapon", get = CTakeDamageInfo.GetWeapon, set = CTakeDamageInfo.SetWeapon },
		{ name = "m_flDamage", get = CTakeDamageInfo.GetDamage, set = CTakeDamageInfo.SetDamage },
		{ name = "m_flMaxDamage", get = CTakeDamageInfo.GetMaxDamage, set = CTakeDamageInfo.SetMaxDamage },
		{ name = "m_flBaseDamage", get = CTakeDamageInfo.GetBaseDamage, set = SetNetPropFloat },
		{ name = "m_flDamageBonus", get = CTakeDamageInfo.GetDamageBonus, set = CTakeDamageInfo.SetDamageBonus },
		{ name = "m_bitsDamageType", get = CTakeDamageInfo.GetDamageType, set = CTakeDamageInfo.SetDamageType },
		{ name = "m_iDamageCustom", get = CTakeDamageInfo.GetDamageCustom, set = CTakeDamageInfo.SetDamageCustom },
		{ name = "m_iDamageStats", get = CTakeDamageInfo.GetDamageStats, set = CTakeDamageInfo.SetDamageStats },
		{ name = "m_iAmmoType", get = CTakeDamageInfo.GetAmmoType, set = CTakeDamageInfo.SetAmmoType },
		{ name = "m_iDamagedOtherPlayers", get = CTakeDamageInfo.GetDamagedOtherPlayers, set = CTakeDamageInfo.SetDamagedOtherPlayers },
		{ name = "m_iPlayerPenetrationCount", get = CTakeDamageInfo.GetPlayerPenetrationCount, set = CTakeDamageInfo.SetPlayerPenetrationCount },
		{ name = "m_bForceFriendlyFire", get = CTakeDamageInfo.IsForceFriendlyFire, set = CTakeDamageInfo.SetForceFriendlyFire },
	]
} );

sqdbg_define_class( FireBulletsInfo_t,
{
	value = function() { return "m_flDamage = " + GetDamage(); },
	custommembers =
	[
		{ name = "m_iShots", get = FireBulletsInfo_t.GetShots, set = FireBulletsInfo_t.SetShots },
		{ name = "m_vecSrc", get = FireBulletsInfo_t.GetSource, set = FireBulletsInfo_t.SetSource },
		{ name = "m_vecDirShooting", get = FireBulletsInfo_t.GetDirShooting, set = FireBulletsInfo_t.SetDirShooting },
		{ name = "m_vecSpread", get = FireBulletsInfo_t.GetSpread, set = FireBulletsInfo_t.SetSpread },
		{ name = "m_flDistance", get = FireBulletsInfo_t.GetDistance, set = FireBulletsInfo_t.SetDistance },
		{ name = "m_iAmmoType", get = FireBulletsInfo_t.GetAmmoType, set = FireBulletsInfo_t.SetAmmoType },
		{ name = "m_iTracerFreq", get = FireBulletsInfo_t.GetTracerFreq, set = FireBulletsInfo_t.SetTracerFreq },
		{ name = "m_flDamage", get = FireBulletsInfo_t.GetDamage, set = FireBulletsInfo_t.SetDamage },
		{ name = "m_iPlayerDamage", get = FireBulletsInfo_t.GetPlayerDamage, set = FireBulletsInfo_t.SetPlayerDamage },
		{ name = "m_nFlags", get = FireBulletsInfo_t.GetFlags, set = FireBulletsInfo_t.SetFlags },
		{ name = "m_flDamageForceScale", get = FireBulletsInfo_t.GetDamageForceScale, set = FireBulletsInfo_t.SetDamageForceScale },
		{ name = "m_pAttacker", get = FireBulletsInfo_t.GetAttacker, set = FireBulletsInfo_t.SetAttacker },
		{ name = "m_pAdditionalIgnoreEnt", get = FireBulletsInfo_t.GetAdditionalIgnoreEnt, set = FireBulletsInfo_t.SetAdditionalIgnoreEnt },
		{ name = "m_bPrimaryAttack", get = FireBulletsInfo_t.GetPrimaryAttack, set = FireBulletsInfo_t.SetPrimaryAttack },
	]
} );

sqdbg_define_class( cplane_t,
{
	value = function() { return format( "[%s] %f", normal.ToKVString(), dist ); },
	metamembers = [ "normal", "dist" ]
} );

sqdbg_define_class( csurface_t,
{
	value = csurface_t.Name,
	custommembers =
	[
		{ name = "surfaceProps", get = csurface_t.SurfaceProps }
	]
} );

sqdbg_define_class( surfacedata_t,
{
	custommembers =
	[
		{ name = "game.jumpFactor", get = surfacedata_t.GetJumpFactor },
		{ name = "game.material", get = surfacedata_t.GetMaterialChar },
		{ name = "physics.friction", get = surfacedata_t.GetFriction },
		{ name = "physics.thickness", get = surfacedata_t.GetThickness },
		{ name = "sounds.breakSound", get = surfacedata_t.GetSoundBreak },
		{ name = "sounds.bulletImpact", get = surfacedata_t.GetSoundBulletImpact },
		{ name = "sounds.impactHard", get = surfacedata_t.GetSoundImpactHard },
		{ name = "sounds.impactSoft", get = surfacedata_t.GetSoundImpactSoft },
		{ name = "sounds.rolling", get = surfacedata_t.GetSoundRolling },
		{ name = "sounds.scrapeRough", get = surfacedata_t.GetSoundScrapeRough },
		{ name = "sounds.scrapeSmooth", get = surfacedata_t.GetSoundScrapeSmooth },
		{ name = "sounds.stepleft", get = surfacedata_t.GetSoundStepLeft },
		{ name = "sounds.stepright", get = surfacedata_t.GetSoundStepRight },
		{ name = "sounds.strainSound", get = surfacedata_t.GetSoundStrain },
	]
} );

sqdbg_define_class( EmitSound_t,
{
	value = function() { return "sound = " + GetSoundName(); },
	custommembers =
	[
		{ name = "m_nChannel", get = EmitSound_t.GetChannel, set = EmitSound_t.SetChannel },
		{ name = "m_pSoundName", get = EmitSound_t.GetSoundName, set = EmitSound_t.SetSoundName },
		{ name = "m_flVolume", get = EmitSound_t.GetVolume, set = EmitSound_t.SetVolume },
		{ name = "m_SoundLevel", get = EmitSound_t.GetSoundLevel, set = EmitSound_t.SetSoundLevel },
		{ name = "m_nFlags", get = EmitSound_t.GetFlags, set = EmitSound_t.SetFlags },
		{ name = "m_nPitch", get = EmitSound_t.GetPitch, set = EmitSound_t.SetPitch },
		{ name = "m_nSpecialDSP", get = EmitSound_t.GetSpecialDSP, set = EmitSound_t.SetSpecialDSP },
		{ name = "m_flSoundTime", get = EmitSound_t.GetSoundTime, set = EmitSound_t.SetSoundTime },
		{
			name = "m_pOrigin",
			get = function() { if ( HasOrigin() ) return GetOrigin(); },
			set = EmitSound_t.SetOrigin
		},
	]
} );

sqdbg_define_class( CScriptKeyValues,
{
	value = CScriptKeyValues.GetName,
	custommembers = function()
	{
		local ret = [];

		for ( local child = GetFirstSubKey(); child; child = child.GetNextKey() )
		{
			local kv = child;
			ret.append( {
				name = kv.GetName(),
				get = function()
				{
					if ( kv.GetFirstSubKey() )
						return kv;
					return kv.GetString();
				},
				set = function( val )
				{
					switch ( typeof val )
					{
						case "string": kv.SetString( val ); break;
						case "integer": kv.SetInt( val ); break;
						case "float": kv.SetFloat( val ); break;
						case "bool": kv.SetBool( val ); break;
					}
				}
			} );
		}

		return ret;
	}
} );
