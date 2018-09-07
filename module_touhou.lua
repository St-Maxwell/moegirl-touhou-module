-- 模块:东方Project
-- 模块:东方Project:称号
-- 模块:东方Project:音乐
-- 模块:东方Project:符卡

local titleZh = mw.loadData("模块:东方Project:称号(中文)")
local titleJp = mw.loadData("模块:东方Project:称号(日文)")
local musicZh = mw.loadData("模块:东方Project:音乐(中文)")
local musicJp = mw.loadData("模块:东方Project:音乐(日文)")
local spellcardZh = mw.loadData("模块:东方Project:符卡(中文)")
local spellcardJp = mw.loadData("模块:东方Project:符卡(日文)")
local spellcardStage = mw.loadData("模块:东方Project:符卡(位置)")
local p = {}

local function getTitle(charName, workName, lang)
    local title
    if lang == "zh" then
        title = titleZh[charName][workName]
    elseif lang == "jp" then
        title = titleJp[charName][workName]
    else
        return "Invalid Input"
    end
    if title then
        return title
    else
        return "Title Not Found"
    end
end

local function getMusic(workName, order, lang)
    local music
    if lang == "zh" then
        music = musicZh[workName][order]
    elseif lang == "jp" then
        music = musicJp[workName][order]
    else
        return "Invalid Input"
    end
    if music then
        return music
    else
        return "Music Not Found"
    end
end

local function getSC(charName, workName, order, lang)
    local spellcard
    if lang == "zh" then
        spellcard = spellcardZh[charName][workName][order]
    elseif lang == "jp" then
        spellcard = spellcardJp[charName][workName][order]
    else
        return "Invalid Input"
    end
    if spellcard then
        return spellcard
    else
        return "Spell Card Not found"
    end
end

local function printSC(charName, workName)
    local tableprint = '<table class="wikitable"><tr><th>符卡原名</th><th>符卡译名</th><th>使用场合</th></tr>'
    local zh, jp, stage
    local num = spellcardZh[charName][workName]["n"]
    for i = 1,num do
        zh = spellcardZh[charName][workName][i]
        jp = spellcardJp[charName][workName][i]
        stage = spellcardStage[charName][workName][i]
        zh = '<td>' .. zh .. '</td>'
        jp = '<td>' .. '<span lang="ja" xml:lang="ja">-{' .. jp .. '}-</span>' .. '</td>'
        stage = '<td>' .. stage .. '</td>'
        tableprint = tableprint .. '<tr>' .. jp .. zh .. stage .. '</tr>'
    end
    return tableprint
end

--称号
--{{#invoke:东方Project|称号|角色|作品(含位置或顺次)|语言}}
p["称号"] = function(frame)
    local charName = frame.args[1]
    local workName = frame.args[2]
    local lang = frame.args[3]
    return getTitle(charName, workName, lang)
end

--音乐
--{{#invoke:东方Project|音乐|作品|顺次(字符串)|语言}}
p["音乐"] = function(frame)
    local workName = frame.args[1]
    local order = frame.args[2]
    local lang = frame.args[3]
    return getMusic(workName, order, lang)
end

--符卡
--{{#invoke:东方Project|符卡|角色|作品|顺次|语言}}
p["符卡"] = function(frame)
    local charName = frame.args[1]
    local workName = frame.args[2]
    local order = tonumber(frame.args[3])
    local lang = frame.args[4]
    return getSC(charName, workName, order, lang)
end

--{{#invoke:东方Project|符卡表|角色|作品}}
p["符卡表"] = function(frame)
    local charName = frame.args[1]
    local workName = frame.args[2]
    return printSC(charName, workName)
end

return p
