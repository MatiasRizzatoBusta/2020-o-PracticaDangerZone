import habilidades.*

class Mision {
	var listaHNecesarias = []
	var peligrosidad
	
	method listaHNecesarias() = listaHNecesarias
	
	method peligrosidad() = peligrosidad
	
	method daniar(empleado) = empleado.reducirSalud(peligrosidad)
	
	method tieneHabilidades(empleado) = listaHNecesarias.all({habilidad => empleado.puedeUsarHabilidad(habilidad)})
	
	method irEnMision(alguien){
		if(alguien.puedeCompletarMision(self)){
			self.daniar(alguien)
			alguien.hacerMision(self)
			}else{
			self.error("No se pudo completar mision")
		}
	}
	
}
