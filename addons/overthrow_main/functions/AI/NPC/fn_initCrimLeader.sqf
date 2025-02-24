params ["_unit","_town","_gangid"];

(group _unit) setVariable ["VCM_NORESCUE",true];
(group _unit) setVariable ["VCM_TOUGHSQUAD",true];
_unit setVariable ["lambs_danger_disableAI", true];

_unit disableAI "PATH";

_unit setVariable ["crimleader",true,true];
_unit setVariable ["hometown",_town,true];

[_unit, (selectRandom OT_faces_local)] remoteExecCall ["setFace", 0, _unit];
[_unit, (selectRandom OT_voices_local)] remoteExecCall ["setSpeaker", 0, _unit];
_unit forceAddUniform (selectRandom OT_CRIM_Clothes);

private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
_unit setUnitLoadout [_gang select 5,true];

if((random 100) < 50) then {
	_unit addItem "OT_Ganja";
};
if((random 100) < 50) then {
	_unit addItem "OT_Blow";
};

_unit addGoggles (selectRandom OT_CRIM_Goggles);

_unit addEventHandler ["Dammaged", OT_fnc_EnemyDamagedHandler];
_unit addEventHandler ["FiredNear", {params ["_unit"];_unit enableAI "PATH"}];
