#!/usr/bin/env bash
# ═══ ABRE LOS PUERTOS 80 y 443 EN ORACLE (copiar y pegar en Cloud Shell del panel OCI) ═══
# Es seguro: primero LEE tus reglas actuales, las conserva y solo AGREGA 80 y 443 si faltan.
set -e
OCID=ocid1.securitylist.oc1.sa-bogota-1.aaaaaaaarq35itlpfo3e3xzheatim55yucljgwjmihoykeuejgy5uqhltuda

echo "▸ Leyendo tus reglas actuales..."
oci network security-list get --security-list-id "$OCID" \
  --query 'data."ingress-security-rules"' --output json > /tmp/reglas_actual.json

python3 - <<'PY' > /tmp/reglas_nuevas.json
import json
actuales = json.load(open('/tmp/reglas_actual.json'))
def puerto(r):
    return ((r.get('tcpOptions') or r.get('tcp-options') or {}).get('destinationPortRange')
            or (r.get('tcpOptions') or r.get('tcp-options') or {}).get('destination-port-range') or {})
nuevas = list(actuales)
for p in (80, 443):
    ya = any(str((puerto(r) or {}).get('max','')) == str(p) or str((puerto(r) or {}).get('min','')) == str(p)
             for r in actuales)
    if not ya:
        nuevas.append({
            "stateless": False,
            "source": "0.0.0.0/0",
            "sourceType": "CIDR_BLOCK",
            "ipProtocol": "6",
            "tcpOptions": {"destinationPortRange": {"min": p, "max": p}}
        })
        print(f"  + se agregara el puerto {p}", file=__import__('sys').stderr)
json.dump(nuevas, open('/dev/stdout','w'))
PY

echo "▸ Reglas que quedaran:"
python3 -c "import json;[print('   origen',r.get('source'),' proto',r.get('ipProtocol'),' puerto',(r.get('tcpOptions') or {}).get('destinationPortRange')) for r in json.load(open('/tmp/reglas_nuevas.json'))]"
echo ""
read -p "▸ Escribir los cambios en Oracle? (s/N) " A
[ "$A" = "s" ] || { echo "cancelado, no se cambio nada"; exit 0; }

oci network security-list update --security-list-id "$OCID" \
  --ingress-security-rules "$(cat /tmp/reglas_nuevas.json)" --force

echo ""
echo "▸ RESULTADO:"
curl -s -o /dev/null -w '   http://149.130.190.118/            -> %{http_code}\n' --max-time 10 http://149.130.190.118/ || true
curl -s -o /dev/null -w '   http://149.130.190.118/tienda.html  -> %{http_code}\n' --max-time 10 http://149.130.190.118/tienda.html || true
echo "   (200 = FUNCIONANDO, ya puedes entrar desde el celular con datos)"
