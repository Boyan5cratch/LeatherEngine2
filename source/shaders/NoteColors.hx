package shaders;

class NoteColors {
	public static var noteColors:Map<String, Array<Int>> = new Map<String, Array<Int>>();

	public static final defaultColors:Map<String, Array<Int>> = [
		"oleft" => [194, 75, 153],
		"odown" => [0, 255, 255],
		"oup" => [18, 250, 5],
		"oright" => [249, 57, 63],
		"midleft" => [204, 204, 204],
		"mid" => [100, 200, 255],
		"midright" => [100, 200, 255],
		"oleft2" => [255, 255, 0],
		"odown2" => [139, 74, 255],
		"oup2" => [255, 0, 0],
		"oright2" => [0, 51, 255],
		"bleft" => [79, 255, 128],
		"bdown" => [137, 78, 8],
		"bup" => [0, 171, 255],
		"bright" => [125, 0, 181],
		"plusleft" => [176, 0, 127],
		"plus" => [100, 200, 255],
		"plusright" => [100, 200, 255],
		"bleft2" => [255, 131, 0],
		"bdown2" => [0, 120, 118],
		"bup2" => [66, 100, 255],
		"bright2" => [130, 255, 174],
		"hleft" => [255, 200, 1],
		"hdown" => [255, 135, 137],
		"hup" => [255, 0, 255],
		"hright" => [0, 163, 30],
		"cubeleft" => [255, 0, 0],
		"cube" => [100, 200, 255],
		"cuberight" => [100, 200, 255],
		"hleft2" => [176, 0, 0],
		"hdown2" => [255, 255, 255],
		"hup2" => [168, 111, 181],
		"hright2" => [61, 180, 102],
		"pleft" => [12, 52, 86],
		"pdown" => [255, 162, 0],
		"pup" => [237, 203, 169],
		"pright" => [255, 0, 214],
		"starleft" => [174, 255, 255],
		"star" => [100, 200, 255],
		"starright" => [100, 200, 255],
		"pleft2" => [135, 255, 173],
		"pdown2" => [255, 0, 68],
		"pup2" => [0, 255, 221],
		"pright2" => [207, 114, 21]
	];

	/**
	 * Haxe version.
	 */
	public static function setNoteColor(note:String, color:Array<Int>):Void {
		if (color == null || color.length < 3)
			return;

		noteColors.set(note, [
			Std.int(Math.max(0, Math.min(255, color[0]))),
			Std.int(Math.max(0, Math.min(255, color[1]))),
			Std.int(Math.max(0, Math.min(255, color[2])))
		]);

		Options.setData(noteColors, "arrowColors", "arrowColors");
	}

	/**
	 * Lua/script-friendly version.
	 *
	 * Example:
	 * setNoteColor("oleft", 255, 0, 0)
	 */
	public static function setNoteColorRGB(note:String, r:Int, g:Int, b:Int):Void {
		setNoteColor(note, [r, g, b]);
	}

	public static function getNoteColor(note:String):Array<Int> {
		if (!noteColors.exists(note)) {
			var defaultColor:Array<Int> = defaultColors.get(note);

			if (defaultColor != null)
				setNoteColor(note, defaultColor);
			else
				return [255, 255, 255];
		}

		return noteColors.get(note);
	}

	public static function load():Void {
		var savedColors:Map<String, Array<Int>> = Options.getData("arrowColors", "arrowColors");

		if (savedColors != null) {
			noteColors = savedColors;
		} else {
			noteColors = new Map<String, Array<Int>>();

			for (note in defaultColors.keys())
				noteColors.set(note, defaultColors.get(note));

			Options.setData(noteColors, "arrowColors", "arrowColors");
		}
	}
}