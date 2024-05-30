private ["_unit"];

_unit = _this select 0;

private _identity = call OT_fnc_randomLocalIdentity;
_identity set [1, selectRandom OT_clothes_shops];
[_unit, _identity] call OT_fnc_applyIdentity;

_unit allowDamage false;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

[_unit,"self"] call OT_fnc_setOwner;

_unit disableAI "MOVE";
_unit disableAI "AUTOCOMBAT";
_unit disableAI "PATH";
_unit disableAI "MINEDETECTION";
_unit disableAI "LIGHTS";
_unit disableAI "FSM";
_unit disableAI "RADIOPROTOCOL";
