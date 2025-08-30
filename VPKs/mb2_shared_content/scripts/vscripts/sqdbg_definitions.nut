
foreach ( key, val in this )
{
	if ( typeof val == "class" )
	{
		sqdbg_define_class( val, { name = key } );
	}
}

local GetNetPropString = function( key ) { return ::NetProps.GetPropString( this, key ); }
local SetNetPropString = function( key, val ) { return ::NetProps.SetPropString( this, key, val ); }
local GetNetPropInt = function( key ) { return ::NetProps.GetPropInt( this, key ); }
local SetNetPropInt = function( key, val ) { return ::NetProps.SetPropInt( this, key, val ); }
local GetNetPropFloat = function( key ) { return ::NetProps.GetPropFloat( this, key ); }
local SetNetPropFloat = function( key, val ) { return ::NetProps.SetPropFloat( this, key, val ); }
local GetNetPropVector = function( key ) { return ::NetProps.GetPropVector( this, key ); }
local SetNetPropVector = function( key, val ) { return ::NetProps.SetPropVector( this, key, val ); }
local GetNetPropEntity = function( key ) { return ::NetProps.GetPropEntity( this, key ); }
local SetNetPropEntity = function( key, val ) { return ::NetProps.SetPropEntity( this, key, val ); }

if ( SERVER_DLL )
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
		{ name = "m_Collision.m_triggerBloat", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMinsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMaxsPreScaled", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMins", get = GetNetPropVector, set = SetNetPropVector },
		{ name = "m_Collision.m_vecSpecifiedSurroundingMaxs", get = GetNetPropVector, set = SetNetPropVector },
	];

	local baseanimating_custommembers = (clone baseentity_custommembers).extend(
	[
		{ name = "m_flGroundSpeed", get = GetNetPropFloat, set = SetNetPropFloat },
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
	]);

	local basecombatcharacter_custommembers = (clone baseanimating_custommembers).extend(
	[
		{ name = "m_flNextAttack", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_flFieldOfView", get = GetNetPropFloat, set = SetNetPropFloat },
		{ name = "m_LastHitGroup", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_CurrentWeaponProficiency", get = GetNetPropInt, set = SetNetPropInt },
		{ name = "m_hActiveWeapon", get = GetNetPropEntity, set = SetNetPropEntity },
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
		{ name = "m_surfaceFriction", get = GetNetPropFloat, set = SetNetPropFloat },
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
		{ name = "m_fEffects", get = GetNetPropInt, set = SetNetPropInt },
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
		{ name = "m_hMoveParent", get = GetNetPropEntity },
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
		{ name = "m_Collision.m_nSurroundType", get = GetNetPropInt, set = SetNetPropInt },
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
			return ::format( "(%s) %d %d %d %d", GetName(), GetXPos(), GetYPos(), GetWide(), GetTall() );
		}
	} );
}

sqdbg_define_class( Vector,
{
	value = Vector.ToKVString,
	metamembers = [ "x", "y", "z" ]
} );

sqdbg_define_class( CGameTrace,
{
	name = "trace_t",
	value = function()
	{
		local ent = Entity();
		if ( ent )
			return ::format( "%f, %s", Fraction(), ""+ent );
		return ::format( "%f", Fraction() );
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

sqdbg_define_class( cplane_t,
{
	value = function() { return ::format( "[%s], %f", normal.ToKVString(), dist ); },
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
		{ name = "m_nSpecialDSP", get = EmitSound_t.GetSpecialDSP, set = EmitSound_t.SetSpecialDSP },
		{ name = "m_flSoundTime", get = EmitSound_t.GetSoundTime, set = EmitSound_t.SetSoundTime },
		{ name = "m_pOrigin", get = EmitSound_t.GetOrigin, set = EmitSound_t.SetOrigin },
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
