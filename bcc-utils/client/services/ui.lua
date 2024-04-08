UIAPI = {}

function UIAPI.CreateRankBar(text, header, alpha, min, max, xp, visible)
    local RBClass = {}

    RBClass.rankbar = DatabindingAddDataContainerFromPath("", "mp_rank_bar")

    function RBClass:SetVisible(state)
        DatabindingAddDataBool(self.rankbar, "isVisible", state)
    end

    function RBClass:SetPrimaryText(text)
        DatabindingAddDataString(self.rankbar, "rank_text", tostring(text))
    end

    function RBClass:SetHeaderText(text)
        DatabindingAddDataString(self.rankbar, "rank_header_text", tostring(text))
    end

    function RBClass:SetPrimaryTextAlpha(alpha)
        DatabindingAddDataInt(self.rankbar, "rank_header_text_alpha", tonumber(alpha))
    end

    function RBClass:SetXPBarMin(val)
        DatabindingAddDataInt(self.rankbar, "xp_bar_minimum", val)
    end

    function RBClass:SetXPBarMax(val)
        DatabindingAddDataInt(self.rankbar, "xp_bar_maximum", val)
    end

    function RBClass:SetXPBarVal(val)
        DatabindingAddDataInt(self.rankbar, "xp_bar_value", val)
    end

    if text ~= nil then
        RBClass:SetPrimaryText(text)
    end

    if header ~= nil then
        RBClass:SetHeaderText(header)
    end

    if alpha ~= nil then
        RBClass:SetPrimaryTextAlpha(alpha)
    end

    if min ~= nil then
        RBClass:SetXPBarMin(min)
    end

    if max ~= nil then
        RBClass:SetXPBarMax(max)
    end

    if xp ~= nil then
        RBClass:SetXPBarVal(xp)
    end

    if visible ~= nil then
        RBClass:SetVisible(visible)
    end


    return RBClass
end