import auditkit as ak
from auditkit.model import Generated, Model, Result_

class Flaky(Model):
    """Answers every question correctly, but 4 of the 10 requests fail (HTTP 500)."""
    name, per_request = "flaky", True
    def generate(self, requests):
        return [Result_([Generated(text="", finish_reason="error", error="HTTP 500")])
                if int(r.prompt[1:]) in (0, 1, 5, 6) else Result_([Generated(text="ok")])
                for r in requests]

data = [ak.Sample(id=str(i), input=f"q{i}", target="ok") for i in range(10)]
opts = {"failed_as_zero": True} if hasattr(ak.RunConfig(), "failed_as_zero") else {}
for flag in ([False, True] if opts else [False]):
    cfg = ak.RunConfig(**({"failed_as_zero": flag} if opts else {}))
    r = ak.evaluate(data, model=Flaky(), scorers=[ak.Contains("ok")], config=cfg)
    print(f"--- failed_as_zero={flag}" if opts else "--- default")
    print("\n".join(r.summary().splitlines()[1:3]))
    print("per-sample correct:", sum(bool(p.correct) for p in r.predictions), "of", len(r.predictions))
