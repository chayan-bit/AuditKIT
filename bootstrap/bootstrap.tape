Output bootstrap.gif
Set Shell bash
Set FontSize 15
Set Width 1300
Set Height 600
Set TypingSpeed 15ms
Set Padding 16
Hide
Type "cd $DEMO_DIR && export PATH=$DEMO_VENV/bin:$PATH XDG_CACHE_HOME=$(mktemp -d) PS1='$ ' && clear" Enter
Show
Type "# upstream main: baseline passes 11%, candidate 80% -- is the difference significant?" Enter
Type "PYTHONPATH=before/src python bootstrap_demo.py 2>&1 | tail -1" Enter
Sleep 5s
Type "# with the fix" Enter
Type "PYTHONPATH=after/src python bootstrap_demo.py 2>&1 | tail -1" Enter
Sleep 5s
Hide
Type "cp after/tests/test_paired_bootstrap.py before/tests/ && clear" Enter
Show
Type "# the new regression test: old code, then fixed code" Enter
Type "(cd before && python -m pytest tests/test_paired_bootstrap.py 2>&1 | tail -3)" Enter
Sleep 4s
Type "(cd after && python -m pytest tests/test_paired_bootstrap.py 2>&1 | tail -3)" Enter
Sleep 4s
Hide
Type "rm before/tests/test_paired_bootstrap.py" Enter
