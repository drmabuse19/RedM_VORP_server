exports('LeftNot', (title, desc, dict, txtr, timer) => {
	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, timer, true);
	const string1 = CreateVarString(10, "LITERAL_STRING", title);
	const string2 = CreateVarString(10, "LITERAL_STRING", desc);
	const struct2 = new DataView(new ArrayBuffer(56));
	struct2.setBigInt64(8, BigInt(string1), true);
	struct2.setBigInt64(16, BigInt(string2), true);
	struct2.setBigInt64(32, BigInt(GetHashKey(dict)), true);
	struct2.setBigInt64(40, BigInt(GetHashKey(txtr)), true);
	struct2.setBigInt64(48, BigInt(GetHashKey("COLOR_WHITE")), true);
	Citizen.invokeNative("0x26E87218390E6729", struct1, struct2, 1, 1);
});

exports('RightNot', (text, dict, icon, text_color, duration) => {
	const _text = CreateVarString(10, "LITERAL_STRING", text);
	const _dict = CreateVarString(10, "LITERAL_STRING", dict);
	const sdict = CreateVarString(10, "LITERAL_STRING", "Transaction_Feed_Sounds");
	const sound = CreateVarString(10, "LITERAL_STRING", "Transaction_Positive");

	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true);
	struct1.setBigInt64(8, BigInt(sdict), true);
	struct1.setBigInt64(16, BigInt(sound), true);


	const struct2 = new DataView(new ArrayBuffer(76));
	struct2.setBigInt64(8, BigInt(_text), true);
	struct2.setBigInt64(16, BigInt(_dict), true);
	struct2.setBigInt64(24, BigInt(GetHashKey(icon)), true);
	struct2.setBigInt64(40, BigInt(GetHashKey(text_color)), true);
	struct2.setInt32(48, 0, true);

	Citizen.invokeNative("0xB249EBCB30DD88E0", struct1, struct2, 1);
});