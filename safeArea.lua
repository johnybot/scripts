-- Name: safeArea
-- Author: Johnybot
-- Based on: NTSC Safe Area from Sour

--    Red: Danger Zone
-- Yellow: Action Safe Area
--   Blue: Post 1985 Safe Area
--  Green: Title Safe Area

function drawSafeArea()

  emu.drawRectangle(  0,   0, 256,   8, 0x88E53935, true)
  emu.drawRectangle(  0, 232, 256,   8, 0x88E53935, true)
  
  emu.drawRectangle(  0,   8,   8, 224, 0x88FDD835, true)
  emu.drawRectangle(248,   8,   8, 224, 0x88FDD835, true)
  emu.drawRectangle(  8,   8, 240,   8, 0x88FDD835, true)
  emu.drawRectangle(  8, 228, 240,   4, 0x88FDD835, true)
  
  emu.drawRectangle(  8,  16,   8, 212, 0x883949AB, true)
  emu.drawRectangle(240,  16,   8, 212, 0x883949AB, true)
  emu.drawRectangle( 16,  16, 224,   8, 0x883949AB, true)
  emu.drawRectangle( 16, 216, 224,  12, 0x883949AB, true)
  
  emu.drawRectangle( 16,  24, 224, 192, 0x8843A047, true)
end

emu.addEventCallback(drawSafeArea, emu.eventType.endFrame);
