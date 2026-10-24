Output metrics.gif
Set Shell bash
Set FontSize 15
Set Width 1300
Set Height 600
Set TypingSpeed 15ms
Set Padding 16
Hide
Type "cd $DEMO_DIR && export PATH=$DEMO_VENV/bin:$PATH XDG_CACHE_HOME=$(mktemp -d) PS1='$ ' && clear" Enter
Show
Type "# upstream main has no structured-extraction metrics" Enter
Type "PYTHONPATH=before/src python -c 'import auditkit as ak; ak.FieldF1' 2>&1 | tail -1" Enter
Sleep 3s
Type "# with this PR: 4 model outputs for one invoice (perfect, 1 wrong field, wrong type, not JSON)" Enter
Type "PYTHONPATH=after/src python metrics_demo.py 2>&1 | tail -8" Enter
Sleep 6s
Type "# tests" Enter
Type "(cd after && python -m pytest tests/test_structured_metrics.py 2>&1 | tail -2)" Enter
Sleep 4s
