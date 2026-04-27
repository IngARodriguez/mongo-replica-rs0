# MongoDB Replica Set rs0 — Configuración Local (Windows)

Replica set con 3 nodos de datos + 1 árbitro corriendo en localhost.

| Nodo    | Puerto | Rol       |
|---------|--------|-----------|
| nodo1   | 27017  | PRIMARY   |
| nodo2   | 27018  | SECONDARY |
| nodo3   | 27019  | SECONDARY |
| arb     | 27020  | ARBITER   |

---

## Instalación desde cero (primera vez)

### 1. Clonar el repo

```bash
git clone https://github.com/IngARodriguez/mongo-replica-rs0
cd mongo-replica-rs0
```

### 2. Ejecutar setup (crea carpetas y copia configs)

Abrir **PowerShell como Administrador** y ejecutar:

```powershell
.\setup.ps1
```

Esto crea `C:\data\nodo1`, `C:\data\nodo2`, `C:\data\nodo3`, `C:\data\arb` y copia el `mongod.cfg` correspondiente en cada uno.

### 3. Encender los nodos

```powershell
.\iniciar.ps1
```

### 4. Inicializar el replica set (solo la primera vez)

```js
mongosh --port 27017
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "localhost:27017", priority: 10 },
    { _id: 1, host: "localhost:27018", priority: 1 },
    { _id: 2, host: "localhost:27019", priority: 1 },
    { _id: 3, host: "localhost:27020", arbiterOnly: true }
  ]
})
```

Esperar ~10 segundos hasta que nodo1 se convierta en PRIMARY.

---

## Uso diario

### Encender

```powershell
.\iniciar.ps1
```

### Apagar

```powershell
.\apagar.ps1
```

### Verificar estado

```js
mongosh --port 27017

rs.status().members.forEach(function(m){ print(m.name, m.stateStr) })
```

Resultado esperado:

```
localhost:27017  PRIMARY
localhost:27018  SECONDARY
localhost:27019  SECONDARY
localhost:27020  ARBITER
```

---

## Estructura del repo

```
replica_rs0/
├── configs/
│   ├── nodo1/mongod.cfg   # puerto 27017
│   ├── nodo2/mongod.cfg   # puerto 27018
│   ├── nodo3/mongod.cfg   # puerto 27019
│   └── arb/mongod.cfg     # puerto 27020 (árbitro)
├── setup.ps1              # Crea carpetas y copia configs (ejecutar una vez)
├── iniciar.ps1            # Enciende los 4 nodos
├── apagar.ps1             # Apaga los 4 nodos limpiamente
└── README.md
```

---

## Requisito

- [MongoDB Community Server](https://www.mongodb.com/try/download/community) instalado y `mongod` / `mongosh` en el PATH.
