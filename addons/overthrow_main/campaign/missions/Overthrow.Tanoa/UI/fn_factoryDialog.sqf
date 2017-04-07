createDialog 'OT_dialog_factory';

private _cursel = lbCurSel 1500;
lbClear 1500;
_done = [];

_numitems = 0;
{
	_cls = _x;
	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_cls = [_x] call BIS_fnc_baseWeapon;
	};

	if !(_cls in _done) then {
		_done pushback _cls;
		_name = "";
		_pic = "";

		_numitems = _numitems + 1;
		if(_cls isKindOf "AllVehicles") then {
			_name = _cls call ISSE_Cfg_Vehicle_GetName;
			_pic = _cls call ISSE_Cfg_Vehicle_GetPic;
		};
		if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
			_name = _cls call ISSE_Cfg_Weapons_GetName;
			_pic = _cls call ISSE_Cfg_Weapons_GetPic;
		};
		if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
			_name = _cls call ISSE_Cfg_Magazine_GetName;
			_pic = _cls call ISSE_Cfg_Magazine_GetPic;
		};
		if(_cls isKindOf "Bag_Base") then {
			_name = _cls call ISSE_Cfg_Vehicle_GetName;
			_pic = _cls call ISSE_Cfg_Vehicle_GetPic;
		};

		_idx = lbAdd [1500,format["%1",_name]];
		lbSetPicture [1500,_idx,_pic];
		lbSetData [1500,_idx,_cls];
	};
}foreach(server getVariable ["GEURblueprints",[]]);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];

[] call OT_fnc_factoryRefresh;
