import empleados.*
import misiones.*
import habilidades.*

class Equipo {
	var integrantes = []
	
	method algunoPuedeCompletar(listaHNecesarias) = integrantes.any({integrante => integrante.puedeCompletarMision(listaHNecesarias)})
	
	method supervivientes() = integrantes.filter({integrante => integrante.sobrevivio()})
	
	method completarMision(mision){
		if(self.algunoPuedeCompletar(mision.listaHNecesarias())){
			const tercioDeDanio = mision.peligrosidad() / 3
			integrantes.forEach({integrante => integrante.recibirDanio(tercioDeDanio)})
			self.supervivientes().forEach({superviviente => superviviente.completarMision(mision)})
			
		}
	}
	
}
