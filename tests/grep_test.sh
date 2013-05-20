describe "grep(1)"

it_displays_usage() {
  usage=$(grep 2>&1 | head -n 1)
  test "$usage" = "Usage: grep [OPTION]... PATTERN [FILE]..."
}

it_will_fail_this_test() {
  echo foo | grep -q bar
}
