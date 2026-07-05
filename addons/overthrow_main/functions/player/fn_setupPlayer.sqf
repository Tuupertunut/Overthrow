OT_Map_LastTownCheckPos = getPosATL player;
OT_Map_LastTown = player call OT_fnc_nearestTown;

player call OT_fnc_statsSystem;
player call OT_fnc_wantedSystem;
player call OT_fnc_townCheckLoop;

[OT_fnc_perkSystem, player, 1] call CBA_fnc_waitAndExecute;
[OT_fnc_notificationLoop, player, 1] call CBA_fnc_waitAndExecute;

player setVariable ["player_uid", getPlayerUID player, true];
player setUnitTrait ["UAVHacker", true];

disableUserInput false;
