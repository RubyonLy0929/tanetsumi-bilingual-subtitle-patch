----------------------------------------
-- Bilingual subtitle defaults
----------------------------------------
tanetsumi_bilingual_sub = tanetsumi_bilingual_sub or {}
local bilingual = tanetsumi_bilingual_sub
local unpack_values = unpack or table.unpack
local math_ceil = math.ceil
local math_floor = math.floor

local layout_cache = setmetatable({}, { __mode = "k" })
local SUBTITLE_GAP = 28
local BOTTOM_MARGIN = 58
local TOP_MIN = 500
local TOP_MAX = 720
local MAIN_LINE_HEIGHT = 88
local SUB_LINE_HEIGHT = 46
local SUB_FONT_SIZE = 28
local SUB_TEXT_COLOR = "0xfff3d0"
local SUB_OUTLINE_COLOR = "0x403e3d"
local estimate_tag_names = {
	exfont = true,
	gaiji = true,
	heroname = true,
	nrt = true,
	rt2 = true,
	txcode = true,
	tximg = true,
	txkey = true,
	txnb = true,
	txnc = true,
	txruby = true,
	wait = true,
}

function bilingual.apply()
	if init then
		init.game_sublangview = "on"
		init.game_sublangblog = "on"
		init.game_sublang = "cn"
	end
	if conf then
		conf.ui_lang = nil
		conf.sub_lang = "cn"
	end
	if type(set_uipath) == "function" then set_uipath() end
end

function bilingual.with_lang(ln, fn, ...)
	local old = bilingual.force_lang
	bilingual.force_lang = ln
	local r = { fn(...) }
	bilingual.force_lang = old
	return unpack_values(r)
end

local function text_segments(node, out)
	if type(node) == "string" then
		out[#out + 1] = node
	elseif type(node) == "table" then
		local tagname = node[1]
		if tagname == "rt2" then
			out[#out + 1] = "\n"
		elseif tagname == "txruby" then
			-- Keep ruby text out of the width estimate; the base text is present nearby.
		elseif type(tagname) == "string" and estimate_tag_names[tagname] then
			if type(node.text) == "string" then
				out[#out + 1] = node.text
			end
			for i = 2, #node do
				text_segments(node[i], out)
			end
		else
			for i, v in ipairs(node) do
				text_segments(v, out)
			end
		end
	end
end

local function estimate_lines(tbl, ln)
	local data = tbl and (tbl[ln] or tbl.ja)
	if type(data) ~= "table" then return 1 end

	local parts = {}
	text_segments(data, parts)

	local capacity = ln == "cn" and 105 or 72
	local lines = 0
	local bytes = 0
	for _, s in ipairs(parts) do
		if s == "\n" then
			if bytes > 0 then
				lines = lines + math_ceil(bytes / capacity)
				bytes = 0
			end
		else
			bytes = bytes + #s
		end
	end
	if bytes > 0 then
		lines = lines + math_ceil(bytes / capacity)
	end
	if lines < 1 then lines = 1 end
	return lines
end

function bilingual.layout_for(tbl)
	if tbl and layout_cache[tbl] then return layout_cache[tbl] end

	local ja_lines = estimate_lines(tbl, "ja")
	local cn_lines = estimate_lines(tbl, "cn")
	local main_height = ja_lines * MAIN_LINE_HEIGHT
	local sub_height = cn_lines * SUB_LINE_HEIGHT
	local needed = main_height + SUBTITLE_GAP + sub_height
	local top = math_floor(1028 - needed - BOTTOM_MARGIN)
	if top < TOP_MIN then top = TOP_MIN end
	if top > TOP_MAX then top = TOP_MAX end

	local layout = {
		top = top,
		name_top = top + 14,
		height = 1028 - top,
		main_height = main_height,
		sub_height = sub_height,
		sub_layer_top = main_height,
	}
	if tbl then layout_cache[tbl] = layout end
	return layout
end

function bilingual.apply_adv_layout(tbl)
	local layout = bilingual.layout_for(tbl)
	tag{
		"font",
		top=(layout.top),
		height=(layout.height),
		spacemiddle=4,
		spacebottom=0,
	}
end

function bilingual.apply_name_layout(tbl)
	local layout = bilingual.layout_for(tbl)
	local id = mw_getmsgid("name")
	tag{"chgmsg", id=(id)}
	tag{"font", top=(layout.name_top), height=(layout.height)}
	tag{"/chgmsg"}
end

local function sub_face()
	local face = init and init.font02 or nil
	if not face then face = "font/NotoSansSC-Medium.ttf" end
	return string.lower(face)
end

function bilingual.apply_sub_visual_style()
	tag{
		"font",
		face=(sub_face()),
		size=(SUB_FONT_SIZE),
		color=(SUB_TEXT_COLOR),
		outline=2,
		outlinecolor=(SUB_OUTLINE_COLOR),
		spacetop=0,
		spacemiddle=2,
		spacebottom=0,
		kerning=-1,
		show=250,
		indent="indent",
		logicalrange=1,
		hung=1,
		rubysize=0,
		prohibit=1,
		layered=1,
	}
end

function bilingual.apply_sub_visual_style_to_layer(id)
	if id then
		tag{"chgmsg", id=(id)}
		bilingual.apply_sub_visual_style()
		tag{"/chgmsg"}
	end
end

function bilingual.apply_sub_layout(tbl)
	local layout = bilingual.layout_for(tbl)
	tag{
		"font",
		face=(sub_face()),
		size=(SUB_FONT_SIZE),
		left=530,
		top=(layout.top),
		width=1280,
		height=(layout.height),
		align="left",
		color=(SUB_TEXT_COLOR),
		outline=2,
		outlinecolor=(SUB_OUTLINE_COLOR),
		spacetop=0,
		spacemiddle=2,
		spacebottom=0,
		kerning=-1,
		show=250,
		indent="indent",
		logicalrange=1,
		hung=1,
		rubysize=0,
		prohibit=1,
		layered=1,
	}
end

function bilingual.sub_layer_top(raw, tbl)
	local layout = bilingual.layout_for(tbl)
	local n = tonumber(raw)
	if not n or n < layout.sub_layer_top then n = layout.sub_layer_top end
	return math_floor(n + SUBTITLE_GAP)
end

local bilingual_get_language = get_language
function get_language(md)
	if bilingual.force_lang and (md == nil or md == false) then
		return bilingual.force_lang
	end
	return bilingual_get_language(md)
end

local bilingual_set_textfont = set_textfont
function set_textfont(name, id, flag)
	local nm = tostring(name or "")
	if nm:find("^adv") or nm:find("^name") then
		return bilingual.with_lang("ja", bilingual_set_textfont, name, id, flag)
	elseif nm:find("^sub") then
		local r = { bilingual.with_lang("cn", bilingual_set_textfont, name, id, flag) }
		bilingual.apply_sub_visual_style_to_layer(id)
		return unpack_values(r)
	end
	return bilingual_set_textfont(name, id, flag)
end

local bilingual_mw_textloop = mw_textloop
function mw_textloop(p)
	local ln = p and p.lang
	if ln then
		if ln == "cn" and conf then
			local old_aread = conf.mw_aread
			conf.mw_aread = 0
			local r = { bilingual.with_lang(ln, bilingual_mw_textloop, p) }
			conf.mw_aread = old_aread
			return unpack_values(r)
		end
		return bilingual.with_lang(ln, bilingual_mw_textloop, p)
	end
	return bilingual_mw_textloop(p)
end

local bilingual_mw_name = mw_name
function mw_name(p)
	bilingual.apply_name_layout(p)
	return bilingual.with_lang("ja", bilingual_mw_name, p)
end

local bilingual_mw_nameflip = mw_nameflip
function mw_nameflip(p)
	return bilingual.with_lang("ja", bilingual_mw_nameflip, p)
end

local bilingual_adv_cls4 = adv_cls4
function adv_cls4(flag)
	local r = bilingual_adv_cls4(flag)
	if init and init.game_sublangview == "on" and type(mw_getmsgid) == "function" then
		tag{"lyprop", id=(mw_getmsgid("sub")), top=0}
	end
	return r
end

function bilingual_apply_sub_layout(p)
	bilingual.apply_sub_layout(p and p.text)
end

function bilingual_prepare_sub_layer(p)
	local tbl = p and p.text
	local id = mw_getmsgid("sub")
	local top = bilingual.sub_layer_top(get_artemis("get_message_layer_height"), tbl)
	bilingual.last_sub_layer_top = top
	tag{"lyprop", id=(id), top=(top)}
end

function bilingual_apply_sub_layer_position()
	local top = bilingual.last_sub_layer_top or bilingual.sub_layer_top(nil, nil)
	tag{"lyprop", id=(mw_getmsgid("sub")), top=(top)}
end

function bilingual_restore_subtitle_after_load()
	bilingual.apply()
	bilingual.apply_sub_visual_style_to_layer(mw_getmsgid("sub"))
	bilingual_apply_sub_layer_position()
end

function message_control(tbl, flag)
	local main_lang = "ja"
	local sub_lang = "cn"

	estag("init")

	local id = mw_getmsgid("adv")
	tag{"chgmsg", id=(id)}
	bilingual.apply_adv_layout(tbl)
	mw_areadfastcheck()
	estag{"mw_textloop", { text=(tbl), lang=(main_lang) }}
	local has_sub = init.game_sublangview == "on" and tbl[sub_lang]
	if has_sub then
		estag{"bilingual_prepare_sub_layer", { text=(tbl) }}
	end
	estag{"/chgmsg"}

	if has_sub then
		local sub_id = mw_getmsgid("sub")
		estag{"chgmsg", id=(sub_id)}
		estag{"bilingual_apply_sub_layout", { text=(tbl) }}
		estag{"mw_areadfastcheck"}
		estag{"mw_textloop", { text=(tbl), lang=(sub_lang) }}
		estag{"/chgmsg"}
		estag{"bilingual_apply_sub_layer_position"}
	end
	if flag then
		estag{"flip"}
		estag{"eqwait"}
	end
	estag()
end

local bilingual_user_conf = user_conf
function user_conf(...)
	if type(bilingual_user_conf) == "function" then bilingual_user_conf(...) end
	bilingual.apply()
end

local bilingual_system_dataloading = system_dataloading
if type(bilingual_system_dataloading) == "function" then
	function system_dataloading(...)
		local r = bilingual_system_dataloading(...)
		bilingual.apply()
		return r
	end
end

local bilingual_restore = restore
if type(bilingual_restore) == "function" then
	function restore(e, p)
		bilingual.after_restore = true
		return bilingual_restore(e, p)
	end
end

local bilingual_quickjumpmsgmain = quickjumpmsgmain
if type(bilingual_quickjumpmsgmain) == "function" then
	function quickjumpmsgmain(...)
		local r = { bilingual_quickjumpmsgmain(...) }
		if bilingual.after_restore then
			bilingual.after_restore = nil
			bilingual_restore_subtitle_after_load()
		end
		return unpack_values(r)
	end
end
