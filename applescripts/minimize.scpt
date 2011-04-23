-- get active window
tell application "System Events"
  set frontApp to name of first application process whose frontmost is true
end tell
-- minimize window
tell application frontApp
  activate
  set miniaturized of window 1 to true
end tell