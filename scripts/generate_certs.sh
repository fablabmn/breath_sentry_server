#!/bin/bash

set -e

CERTS_DIR="../mosquitto/certs"
mkdir -p "$CERTS_DIR"
cd "$CERTS_DIR"

echo "🔐 Generazione certificati Mosquitto..."

# --- CA (Certificate Authority) ---
echo "→ Generazione CA..."
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 3650 \
    -key ca.key \
    -out ca.crt \
    -subj "/C=IT/ST=Lombardia/L=Mantova/O=FablabMantova/CN=SentryCA"

# --- Server certificate ---
echo "→ Generazione certificato server..."
openssl genrsa -out server.key 2048
openssl req -new \
    -key server.key \
    -out server.csr \
    -subj "/C=IT/ST=Lombardia/L=Mantova/O=FablabMantova/CN=localhost"

openssl x509 -req -days 3650 \
    -in server.csr \
    -CA ca.crt \
    -CAkey ca.key \
    -CAcreateserial \
    -out server.crt

# Pulizia file temporanei
rm -f server.csr ca.srl

# Permessi corretti per Mosquitto
chmod 600 *.key
chmod 644 *.crt

echo ""
echo "✅ Certificati generati in $CERTS_DIR:"
ls -lah
echo ""
echo "⚠️  Le chiavi .key sono private — non committarle su git!"
