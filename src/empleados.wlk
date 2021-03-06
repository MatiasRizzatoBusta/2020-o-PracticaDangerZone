import misiones.*
import habilidades.*

class Empleado {
	var salud
	var habilidades = []
	var clase
	var rango
	
	method estaIncapacitado() = salud < clase.saludCritica()
	
	method habilidades() = habilidades
	
	method puedeUsarHabilidad(habilidad){
		if(not(self.estaIncapacitado())){
			return rango.poseeHabilidad(habilidad,self)
		}else{
			return false
		}
	}
	
	method reducirSalud(danio){
		salud = 0.max(salud -danio)
	}
	
	method tieneHabilidad(habilidadRequerida) = habilidades.contains(habilidadRequerida) 	
	
	method aprenderHabilidad(habilidad) = habilidades.add(habilidad)
	
	method sobrevivio() = salud > 0
	
	method puedeCompletarMision(mision) = mision.tieneHabilidades(self)
	
	method hacerMision(mision){
		if(self.sobrevivio()){
			self.terminarMision(mision)
		}
	}
	
	method terminarMision(mision){
		clase.misionCumplida(mision,self)
		
	}
	

}

class Clase{ // no hago que hereden de empleado como antes pq el completar mision es igual para ambos salvo por el mision cumplida
	method saludCritica()
	
	method misionCumplida(mision,empleado)
}

object espia inherits Clase{
	
	override method saludCritica() = 15
	
	override method misionCumplida(mision,empleado){
		mision.listaHNecesarias().forEach({habilidad => empleado.aprenderHabilidad(habilidad)})
		empleado.habilidades().asSet()
	}
	
}

class Oficinista inherits Clase{
	var estrellas = 0 //lo pongo aca porque solo le importan a el
	
	method ganarEstrella(){
		estrellas += 1
	}
	
	method estrellas() = estrellas
		
	override method saludCritica() = 40 -(5 * estrellas)
	
	override method misionCumplida(mision,empleado){
		self.ganarEstrella()
	}
	
}

// OBJETOS DE RANGO

class Rango{
	
	method esJefe() = false
	
	method poseeHabilidad(habilidad,empleado) = empleado.tieneHabilidad(habilidad)
}

class Jefe inherits Rango{ // podria haber hecho que el jefe herede de empleado
							// en el diagrama falta hacer que e 
	var subordinados
	
	override method esJefe() = true
	
	method subordinados() = subordinados
	
	override method poseeHabilidad(habilidad,empleado) = self.algunSubordinadoCumple(habilidad) || super(habilidad,empleado)
	
	method algunSubordinadoCumple(habilidad) = subordinados.any({subordinado => subordinado.tieneHabilidad(habilidad)})

}

object subordinado inherits Rango{}