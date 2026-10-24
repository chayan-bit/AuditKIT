import json
import auditkit as ak

schema = {"type": "object", "required": ["id", "total"], "additionalProperties": False,
          "properties": {"id": {"type": "string"}, "total": {"type": "number"},
                         "items": {"type": "array", "items": {"type": "object"}}}}
target = json.dumps({"id": "INV-7", "total": 118.0, "items": [{"sku": "a", "qty": 2}, {"sku": "b", "qty": 1}]})
outputs = [
    target,                                                                   # perfect
    json.dumps({"id": "INV-7", "total": 118.0, "items": [{"sku": "a", "qty": 3}, {"sku": "b", "qty": 1}]}),  # one wrong field
    '{"id": "INV-7", "total": "118"}',                                        # total has the wrong type
    "Sure! Here is the invoice: {id: INV-7}",                                 # not JSON
]
data = [ak.Sample(id=str(i), input="extract the invoice", target=target, actual_output=o)
        for i, o in enumerate(outputs)]
r = ak.evaluate(data, model="precomputed",
                scorers=[ak.JsonSchemaValid(schema), ak.FieldF1(list_keys="sku")])
print("\n".join(r.summary().splitlines()[1:5]))
for p in r.predictions:
    print(p.sample_id, [(s["name"], round(s["value"], 2)) for s in p.metadata["scores"] if s["name"] != "field_precision"])
