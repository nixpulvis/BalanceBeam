-- Frame
local eclipse = CreateFrame("Frame", "BB Eclipse Bar", UIParent);
eclipse:SetSize(350, 25);
eclipse:SetPoint("CENTER", UIParent, "CENTER", 0, -300);
eclipse:SetFrameLevel(1);
eclipse:SetBackdrop({
  bgFile = "Interface\\AddOns\\BalanceBeam\\blank",
  edgeFile = "Interface\\AddOns\\BalanceBeam\\blank",
  tile = true,
  tileSize = 32,
  edgeSize = 1
});
eclipse:SetBackdropColor(0.175, 0.175, 0.175);
eclipse:SetBackdropBorderColor(0.1, 0.1, 0.1);

-- Lunar
eclipse.lunar = CreateFrame("Frame", nil, eclipse);
eclipse.lunar:ClearAllPoints();
eclipse.lunar:SetPoint("TOPLEFT", eclipse, "TOPLEFT", 1, -1);
eclipse.lunar:SetPoint("BOTTOMLEFT", eclipse, "BOTTOMLEFT", 1, 1);
eclipse.lunar:SetPoint("RIGHT", eclipse, "CENTER", 0, 0);
eclipse.lunar:SetFrameLevel(2);
eclipse.lunar:SetBackdrop({
  bgFile = "Interface\\AddOns\\BalanceBeam\\blank",
  edgeFile = "Interface\\AddOns\\BalanceBeam\\blank",
  tile = true,
  tileSize = 32,
  edgeSize = 1
});
eclipse.lunar:SetBackdropColor(65/255, 105/255, 255/255);
eclipse.lunar:SetBackdropBorderColor(0, 0, 0, 0);
eclipse.lunar.bar = CreateFrame("StatusBar", nil, eclipse.lunar);
eclipse.lunar.bar:SetAllPoints();
eclipse.lunar.bar:SetFrameLevel(3);
eclipse.lunar.bar:SetStatusBarTexture("Interface\\AddOns\\BalanceBeam\\blank");
eclipse.lunar.bar:SetStatusBarColor(32/255, 52/255, 112/255);
eclipse.lunar.bar:SetMinMaxValues(-100, 0);
eclipse.lunar.cast = CreateFrame("StatusBar", nil, eclipse.lunar);
eclipse.lunar.cast:SetWidth(20);
eclipse.lunar.cast:SetHeight(eclipse.lunar.bar:GetHeight()/2);
eclipse.lunar.cast:SetFrameLevel(3);
eclipse.lunar.cast:SetStatusBarTexture("Interface\\AddOns\\BalanceBeam\\blank");
eclipse.lunar.cast:SetStatusBarColor(.5,.5,.5,.5);
eclipse.lunar.cast:SetMinMaxValues(0, 1);

-- Solar
eclipse.solar = CreateFrame("Frame", nil, eclipse);
eclipse.solar:ClearAllPoints();
eclipse.solar:SetPoint("TOPRIGHT", eclipse, "TOPRIGHT", -1, -1);
eclipse.solar:SetPoint("BOTTOMRIGHT", eclipse, "BOTTOMRIGHT", -1, 1);
eclipse.solar:SetPoint("LEFT", eclipse, "CENTER", 0, 0);
eclipse.solar:SetFrameLevel(2);
eclipse.solar:SetBackdrop({
  bgFile = "Interface\\AddOns\\BalanceBeam\\blank",
  edgeFile = "Interface\\AddOns\\BalanceBeam\\blank",
  tile = true,
  tileSize = 32,
  edgeSize = 1
});
eclipse.solar:SetBackdropColor(109/255, 82/255, 16/255);
eclipse.solar:SetBackdropBorderColor(0, 0, 0, 0);
eclipse.solar.bar = CreateFrame("StatusBar", nil, eclipse.solar);
eclipse.solar.bar:SetAllPoints();
eclipse.solar.bar:SetFrameLevel(3);
eclipse.solar.bar:SetStatusBarTexture("Interface\\AddOns\\BalanceBeam\\blank");
eclipse.solar.bar:SetStatusBarColor(218/255, 165/255, 32/255);
eclipse.solar.bar:SetMinMaxValues(0, 100);

-- Overlay
eclipse.overlay = CreateFrame("Frame", nil, eclipse);
eclipse.overlay:SetAllPoints();
eclipse.overlay:SetFrameLevel(4);

-- Text
eclipse.overlay.text = eclipse.overlay:CreateFontString("text", "OVERLAY");
eclipse.overlay.text:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
eclipse.overlay.text:ClearAllPoints();
eclipse.overlay.text:SetPoint("BOTTOM", eclipse.overlay, "TOP", 0, 3);

-- Script
local last = 0;
eclipse:SetScript("OnUpdate", function(self, event, uid, type)
  local current = UnitPower("player",  8);

  eclipse.lunar.bar:SetValue(current);
  eclipse.solar.bar:SetValue(current);

  local lunar_x = current / 100 * eclipse.lunar:GetWidth();
  if last > current then
    eclipse.lunar.cast:ClearAllPoints();
    eclipse.lunar.cast:SetPoint("TOPRIGHT", eclipse.lunar, "TOPRIGHT", lunar_x, 0);
  elseif last < current then
    eclipse.lunar.cast:ClearAllPoints();
    eclipse.lunar.cast:SetPoint("TOPLEFT", eclipse.lunar, "TOPRIGHT", lunar_x, 0);
  end

  if current > 0 then
    eclipse.overlay.text:SetText(string.format("%d (S)", current));
  else
    eclipse.overlay.text:SetText(string.format("%d (L)", abs(current)));
  end

  last = current;
end);