# setup.ps1 — Ejecutar UNA sola vez al clonar el repo
# Crea las carpetas de datos y copia los configs a C:\data\

Write-Host "=== Configurando Replica Set rs0 ===" -ForegroundColor Cyan

$nodos = @("nodo1", "nodo2", "nodo3", "arb")

foreach ($nodo in $nodos) {
    $ruta = "C:\data\$nodo"
    if (-not (Test-Path $ruta)) {
        New-Item -ItemType Directory -Path $ruta -Force | Out-Null
        Write-Host "  Creada carpeta: $ruta" -ForegroundColor Green
    } else {
        Write-Host "  Ya existe: $ruta" -ForegroundColor Yellow
    }
    Copy-Item -Path ".\configs\$nodo\mongod.cfg" -Destination $ruta -Force
    Write-Host "  Config copiada -> $ruta\mongod.cfg" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Setup completado ===" -ForegroundColor Cyan
Write-Host "Ahora ejecuta: .\iniciar.ps1" -ForegroundColor White
