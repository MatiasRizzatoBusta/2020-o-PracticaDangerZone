import empleados.*
import misiones.*
import habilidades.*

class Equipo {
	var integrantes = []
	
	method puedeCompletarMision(mision) = integrantes.any({integrante => mision.tieneHabilidades(integrante)})
	
	method sobrevivio() = integrantes.any({integrante => integrante.sobrevivio()})
	
	method supervivientes() = integrantes.filter({integrante => integrante.sobrevivio()})
	
	method hacerMision(mision){
		if(self.sobrevivio()){
			self.terminarMision(mision)
		}
	}
	
	method terminarMision(mision){
		self.supervivientes().forEach({superviviente => superviviente.terminarMision(mision)})
		
		}
	
}
