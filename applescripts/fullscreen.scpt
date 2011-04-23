-- get Dock height
tell application "System Events" to tell process "Dock"
  set dock_dimensions to size in list 1
  set dock_height to item 2 of dock_dimensions
end tell
-- get the new width and height for the window
tell application "Finder"
  set desktop_dimensions to bounds of window of desktop
  set new_width to (item 3 of desktop_dimensions) / 2
  set new_height to (item 4 of desktop_dimensions) - dock_height
end tell
-- get active window
tell application "System Events"
  set frontApp to name of first application process whose frontmost is true
end tell
-- resize window
tell application frontApp
  activate
  set bounds of window 1 to {0, 0, new_width * 2, new_height}
end tell