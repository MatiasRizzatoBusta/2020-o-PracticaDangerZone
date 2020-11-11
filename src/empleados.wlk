import misiones.*
import habilidades.*

class Empleado {
	var salud
	var habilidades 
	var clase
	var rango
	var  estrellas = 0
	
	method estrellas() = estrellas
	
	method estaIncapacitado() = salud < clase.saludCritica(self)
	
	method habilidades() = habilidades
	
	method ganarEstrella(){
		estrellas += 1
	}
	
	method puedeUsarHabilidad(habilidad){
		if(not(self.estaIncapacitado())){
			return rango.poseeHabilidad(habilidad,self)
		}else{
			return false
		}
	}
	
	method tieneHabilidad(habilidadRequerida) = habilidades.contains(habilidadRequerida) 
	
	method puedeCompletarMision(listaHNecesarias) =	listaHNecesarias.all({habilidad => rango.poseeHabilidad(habilidad,self)})
	
	method aprenderHabilidad(habilidad) = habilidades.add(habilidad)
	
	method sobrevivio() = salud > 0
	
	method recibirDanio(danio){
		salud = 0.max(salud -danio)
	}
	
	method completarMision(mision){
		if(self.puedeCompletarMision(mision.listaHNecesarias())){
			self.recibirDanio(mision.peligrosidad())
			if(self.sobrevivio()){
				clase.misionCumplida(mision,self)
			}
		}else{
			self.error("No se pudo completar mision")
		}
	}
}

class Clase{ // no hago que hereden de empleado como antes pq el completar mision es igual para ambos salvo por el mision cumplida
	method saludCritica(empleado)
	
	method misionCumplida(mision,empleado)
}

object espia inherits Clase{
	
	override method saludCritica(empleado) = 15
	
	override method misionCumplida(mision,empleado){
		mision.listaHNecesarias().forEach({habilidad => empleado.aprenderHabilidad(habilidad)})
		empleado.habilidades().asSet()
	}
	
}

object oficinista inherits Clase{
	override method saludCritica(empleado) = 40 -(5 * empleado.estrellas())
	
	override method misionCumplida(mision,empleado){
		empleado.ganarEstrella()
	}
	
}

// OBJETOS DE RANGO

class Rango{
	
	method esJefe() = false
	
	method poseeHabilidad(habilidad,empleado) = empleado.tieneHabilidad(habilidad)
}

class Jefe inherits Rango{
	var subordinados
	
	override method esJefe() = true
	
	method subordinados() = subordinados
	
	override method poseeHabilidad(habilidad,empleado) = self.algunSubordinadoCumple(habilidad) || super(habilidad,empleado)
	
	method algunSubordinadoCumple(habilidad) = subordinados.any({subordinado => subordinado.tieneHabilidad(habilidad)})

}

object subordinado inherits Rango{}