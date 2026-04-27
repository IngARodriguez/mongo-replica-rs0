# iniciar.ps1 — Enciende los 4 nodos del replica set en ventanas separadas

Write-Host "=== Iniciando Replica Set rs0 ===" -ForegroundColor Cyan

Start-Process "mongod" -ArgumentList '--config "C:\data\nodo1\mongod.cfg"' -WindowStyle Normal
Write-Host "  nodo1 iniciado (puerto 27017)" -ForegroundColor Green

Start-Sleep -Seconds 1

Start-Process "mongod" -ArgumentList '--config "C:\data\nodo2\mongod.cfg"' -WindowStyle Normal
Write-Host "  nodo2 iniciado (puerto 27018)" -ForegroundColor Green

Start-Sleep -Seconds 1

Start-Process "mongod" -ArgumentList '--config "C:\data\nodo3\mongod.cfg"' -WindowStyle Normal
Write-Host "  nodo3 iniciado (puerto 27019)" -ForegroundColor Green

Start-Sleep -Seconds 1

Start-Process "mongod" -ArgumentList '--config "C:\data\arb\mongod.cfg"' -WindowStyle Normal
Write-Host "  arbitro iniciado (puerto 27020)" -ForegroundColor Green

Write-Host ""
Write-Host "Espera ~5 segundos y verifica con: mongosh --port 27017 --eval `"rs.status()`"" -ForegroundColor White
