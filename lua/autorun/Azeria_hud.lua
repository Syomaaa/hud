------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local hide = {

    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["DarkRP_Hungermod"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["DarkRP_HUD"] = true,
}
hook.Add( "HUDShouldDraw", "DefautHUD", function(name)
	if hide[name] then return false end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- groupe d image
local bcilux1 = Material("blackclovermatilux/blackcloverilux.png", "noclamp smooth")
local bcilux2 = Material("blackclovermatilux/moneybcilux.png", "noclamp smooth")
local bcilux3 = Material("blackclovermatilux/steakbcilux.png", "noclamp smooth")

local show = nil
local function AzeriaRespX(sx) return ScrW() / 1920 * sx end
local function AzeriaRespY(sy) return ScrH() / 1080 * sy end
local function AzeriaResp(sx, sy) return AzeriaRespX(sx), AzeriaRespY(sy) end  

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if CLIENT then
    surface.CreateFont( "font_bc_partout", {
        font = "blackcloverfont",
        extended = false,
        size = AzeriaRespX(38),
        antialias = true,
    } )

    surface.CreateFont( "font_bc_name", {
        font = "blackcloverfont",
        extended = false,
        size = AzeriaRespX(40),
        antialias = true,
    } )

    surface.CreateFont( "font_bc_money", {
        font = "blackcloverfont",
        extended = false,
        size = AzeriaRespX(50),
        antialias = true,
    } )

end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function DrawPModelPanel()
    local pPanel = vgui.Create("DPanel")
    pPanel:SetPos(AzeriaResp(75, 825))
    pPanel:SetSize(AzeriaResp(120, 120))
    function pPanel:Paint() end

    show = vgui.Create("DModelPanel", pPanel)
    show:Dock(FILL)
    show:SetModel(LocalPlayer():GetModel())
    show:SetCamPos(Vector(40, -0, 60))
    show:SetFOV(55)
    show:SetLookAt(Vector(0, 0, 60))
    show.Think = function()
        if not LocalPlayer():Alive() then
            pPanel:SetSize(AzeriaResp(50, 50))
        else
            pPanel:SetSize(AzeriaResp(180, 180))
        end
        
        show:SetModel(LocalPlayer():GetModel())
    end
    show.LayoutEntity = function()
        return false
    end
    return show
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local currentHp = 0
local currentHP_percent

local currentMana = 0
local currentMana_percent

hook.Add("HUDPaint", "Azeria_hud", function()

    local health = math.Clamp(LocalPlayer():Health(), 0, 100)
    local healthMax = LocalPlayer():GetMaxHealth()

    currentHp = Lerp(FrameTime() * 1.5, currentHp, LocalPlayer():Health())
    currentHP_percent = math.Clamp(currentHp / LocalPlayer():GetMaxHealth(), 0, 1)

    draw.RoundedBox(4, AzeriaRespX(280),AzeriaRespY(947), currentHP_percent * AzeriaRespX(300), AzeriaRespY(30),Color(255,0,0))-- barre de vie
    draw.SimpleText(tostring(LocalPlayer():Health()) .. "/" .. healthMax,"font_bc_partout", AzeriaRespX(430) , AzeriaRespY(961),Color( 255, 255, 255),1,1)--vie

--------------------------------------------------------------------------

    local manaText = LocalPlayer():GetMana()
    local manaMax = LocalPlayer():GetMaxMana()
    print("[DEBUG] Mana: " .. manaText .. "/" .. manaMax)

    currentMana = Lerp(FrameTime() * 1.5, currentMana, LocalPlayer():GetMana())
    currentMana_percent = math.Clamp(currentMana / LocalPlayer():GetMaxMana(), 0, 1)


    draw.RoundedBox(4, AzeriaRespX(280), AzeriaRespY(974), currentMana_percent * AzeriaRespX(300), AzeriaRespY(35), Color(0, 0, 255, 255))
    draw.SimpleText(math.floor(manaText) .. "/" .. manaMax,"font_bc_partout", AzeriaRespX(430), AzeriaRespY(991.5), Color( 255, 255, 255),1,1)

--------------------------------------------------------------------------

    local food = math.Clamp(LocalPlayer():getDarkRPVar("Energy"), 0, 100)
    local name = LocalPlayer():Name()
    local Imoney = LocalPlayer():getDarkRPVar("money")


      
    --Nametag
    surface.SetMaterial(bcilux1) 
    surface.SetDrawColor( color_white )
    surface.DrawTexturedRect(AzeriaRespX(7), AzeriaRespY(789),AzeriaRespX(620), AzeriaRespY(320) ) -- hud
        
    draw.SimpleText(name,"font_bc_name",AzeriaRespX(385), AzeriaRespY(885), Color( 190,190,190),1,1) -- Nom du joueur  
    
    --Bouffe
    surface.SetMaterial(bcilux3) 
    surface.SetDrawColor( color_white )
    surface.DrawTexturedRect(AzeriaRespX(290), AzeriaRespY(1015),AzeriaRespX(50),AzeriaRespY(45) ) -- steak

    

    --Argent
    surface.SetMaterial(bcilux2) 
    surface.SetDrawColor( color_white )
    surface.DrawTexturedRect(AzeriaRespX(435), AzeriaRespY(1018), AzeriaRespX(60),AzeriaRespY(45) ) --argent
    
    draw.SimpleText(Imoney,"font_bc_money",AzeriaRespX(510), AzeriaRespY(1015), Color( 255, 247,0), TEXT_ALIGN_LEFT) -- argent du joueur 
    draw.SimpleText(food,"font_bc_money",AzeriaRespX(368), AzeriaRespY(1015), Color( 255, 85, 0), TEXT_ALIGN_LEFT) -- Faim du joueur
end)
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------