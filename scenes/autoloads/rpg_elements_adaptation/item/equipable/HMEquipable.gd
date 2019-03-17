extends HMItem

class_name HMEquipable

enum Equipable {
	NONE = -1,
	PRIMARY_WEAPON,
	SECUNDARY_WEAPON,
	SHIELD,
	ARTIFACT,
	ARMOR,
	TOOL
}
var equiped_how = Equipable.NONE