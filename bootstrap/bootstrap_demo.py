import random
import auditkit as ak

random.seed(0)
data = [ak.Sample(id=str(i), input=f"q{i}", target="ok") for i in range(100)]

def model(rate):
    rng = random.Random(1)
    return lambda prompts: ["ok" if rng.random() < rate else "no" for _ in prompts]

base = ak.evaluate(data, model=model(0.11), scorers=[ak.Contains("ok")], experiment_name="base")
cand = ak.evaluate(data, model=model(0.80), scorers=[ak.Contains("ok")], experiment_name="cand")
print("baseline", base.headline, "candidate", cand.headline)
print(ak.compare(base, cand).significance())
