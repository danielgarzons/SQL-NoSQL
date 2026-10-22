// ==========================================
// TALLER RPG MANAGER - CONSULTAS MONGODB
// Programacion multinivel
// ==========================================

// 1. Obtener todos los personajes de clase Guerrero
db.personajes.find({ clase: "Guerrero" });

// 2. Proyección: Mostrar únicamente nombre y oro
db.personajes.find({}, { nombre: 1, oro: 1, _id: 0 });

// 3. Filtros combinados: Nivel mayor a 10 Y oro mayor a 200
db.personajes.find({
  nivel: { $gt: 10 },
  oro: { $gt: 200 }
});

// 4. Búsqueda en arrays embebidos: Personajes con "Espada de Hierro"
db.personajes.find({
  "inventario.item": "Espada de Hierro"
});

// ==========================================
// TALLER RPG MANAGER - CONSULTAS MONGODB
// Estudiante: Juan Daniel Garzón Solaque
// ==========================================

// 1. Obtener todos los personajes de clase Guerrero
db.personajes.find({ clase: "Guerrero" });

// 2. Proyección: Mostrar únicamente nombre y oro
db.personajes.find({}, { nombre: 1, oro: 1, _id: 0 });

// 3. Filtros combinados: Nivel mayor a 10 Y oro mayor a 200
db.personajes.find({
  nivel: { $gt: 10 },
  oro: { $gt: 200 }
});

// 4. Búsqueda en arrays embebidos: Personajes con "Espada de Hierro"
db.personajes.find({
  "inventario.item": "Espada de Hierro"
});

// 5. Modificación de documentos: Incrementar oro a Thorgar (+50)
db.personajes.update(
  { _id: 1 },
  { $inc: { oro: 50 } }
);

// 6. Consultar arrays embebidos: Personajes con misiones completadas
db.personajes.find({
  "misiones.estado": "completada"
});

// 7. Agregar elemento a array embebido: Escudo de Madera para Thorgar
db.personajes.update(
  { _id: 1 },
  { $push: { inventario: { item: "Escudo de Madera", tipo: "armadura", valor: 20, cantidad: 1 } } }
);

// 8. Eliminar elemento de array embebido: Quitar Poción de Vida a Thorgar
db.personajes.update(
  { _id: 1 },
  { $pull: { inventario: { item: "Pocion de Vida" } } }
);