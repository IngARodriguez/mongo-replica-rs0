# apagar.ps1 — Apaga los 4 nodos del replica set de forma limpia

Write-Host "=== Apagando Replica Set rs0 ===" -ForegroundColor Cyan

$puertos = @(27017, 27018, 27019, 27020)
$nombres = @("nodo1", "nodo2", "nodo3", "arbitro")

for ($i = 0; $i -lt $puertos.Length; $i++) {
    $puerto = $puertos[$i]
    $nombre = $nombres[$i]
    try {
        mongosh --port $puerto --eval "db.adminCommand({shutdown: 1})" --quiet 2>$null
        Write-Host "  $nombre (puerto $puerto) apagado" -ForegroundColor Green
    } catch {
        Write-Host "  $nombre (puerto $puerto) no estaba activo" -ForegroundColor Yellow
    }
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "=== Todos los nodos apagados ===" -ForegroundColor Cyan
