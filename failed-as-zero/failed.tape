Output failed.gif
Set Shell bash
Set FontSize 15
Set Width 1300
Set Height 600
Set TypingSpeed 15ms
Set Padding 16
Hide
Type "cd $DEMO_DIR && export PATH=$DEMO_VENV/bin:$PATH XDG_CACHE_HOME=$(mktemp -d) PS1='$ ' && clear" Enter
Show
Type "# a model answers 6 of 10 correctly and its other 4 requests fail (HTTP 500)" Enter
Type "# upstream main: the headline only counts the 6 that returned" Enter
Type "PYTHONPATH=before/src python failed_demo.py 2>&1 | grep -v '^ERROR\|failed:'" Enter
Sleep 5s
Type "# with this PR: the default is unchanged but the failures are reported, and failed_as_zero=True counts them" Enter
Type "PYTHONPATH=after/src python failed_demo.py 2>&1 | grep -v '^ERROR\|failed:'" Enter
Sleep 6s
Type "# the new tests" Enter
Type "(cd after && python -m pytest tests/test_failed_as_zero.py 2>&1 | tail -2)" Enter
Sleep 4s
