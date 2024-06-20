params ["_user"];

private _range = 150;
private _time = 15;

private _veh = vehicle _user;
if (_veh == _user) exitWith {};
if ((driver _veh) != _user) exitWith {
    "Loot must be initiated by the driver of this vehicle" call OT_fnc_notifyMinor;
};
if ((typeOf _veh) != "OT_I_Truck_recovery") exitWith {
    "This command is only available when using a Recovery truck" call OT_fnc_notifyMinor;
};

if (isPlayer _user) then {
    _veh enableSimulation false;
    _veh spawn {
        sleep (_time + 5);
        _this enableSimulation true;
        //Fail safe for user input disabled.
    };
    format ["Looting all bodies within %1m",_range] call OT_fnc_notifyMinor;
    [_time, false] call OT_fnc_progressBar;
} else {
    _user globalchat format["Looting bodies within %1m using Recovery vehicle",_range];
};

sleep _time;

//Get the loose weapons
private _count_weapons = 0;
private _weapons = (_veh nearObjects ["WeaponHolder", _range]) + (_veh nearEntities ["WeaponHolderSimulated", _range]);
{
    _weapon = _x;
    _s = (weaponsItems _weapon) select 0;
    if (!isNil {_s}) then {
        _cls = (_s # 0);
        _i = _s # 1;
        if (_i != "") then {_veh addItemCargoGlobal [_i, 1]};
        _i = _s # 2;
        if (_i != "") then {_veh addItemCargoGlobal [_i, 1]};
        _i = _s # 3;
        if (_i != "") then {_veh addItemCargoGlobal [_i, 1]};

        _veh addWeaponCargoGlobal [_cls call BIS_fnc_baseWeapon, 1];
        deleteVehicle _weapon;
        _count_weapons = _count_weapons + 1;
    };
} foreach _weapons;

//Get the bodies
private _count_bodies = 0;
{
    if !(_x isKindOf "CAManBase") then {continue};
    if (_x distance _veh < _range) then {
        [_x, _veh] call OT_fnc_dumpStuff;
        _count_bodies = _count_bodies + 1;
        [_x] call OT_fnc_cleanupUnit;
    };
} foreach allDeadMen;

if(isPlayer _user) then {
    _veh enableSimulation true;
    format["Looted %1 weapons and %2 bodies into this truck", _count_weapons, _count_bodies] call OT_fnc_notifyMinor;
}else {
    _user globalchat format["All done! Looted %1 weapons and %2 bodies", _count_weapons, _count_bodies];
};
