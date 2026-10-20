class Barrios{
  const elementos = []

  method elementosDisponibles(){
    return [Hogar, Huerta, Mascota]
  }
  method elementos() = elementos
  method añadirElementos(unElemento){
    elementos.add(unElemento)
  }

  method esCopado() {
    const cantidadBuenos = elementos.count({ e => e.esBueno() })
    const cantidadNoBuenos = elementos.size() - cantidadBuenos
    return cantidadBuenos > cantidadNoBuenos
  }

}


class Hogar{
  var nivelDeMugre
  var comfort

  method nivelDeMugre() = nivelDeMugre
  method comfort() = comfort

  method cambiarNivelDeMugre(unNivelDeMugre){
    nivelDeMugre = unNivelDeMugre
  } 

  method cambiarNivelDeComfort(unNivelDeConfort){
    comfort = unNivelDeConfort
  }

  method esBueno(){
    return nivelDeMugre <= (comfort / 2)
  }
  
  method recibirConsequenciasAtaque(unaPlaga){
    nivelDeMugre += unaPlaga.daño()
    return nivelDeMugre
  }
}

class Huerta{
  var capacidadDeProduccion
  var property nivelParaProduccionDeHuerta

  method capacidadDeProduccion() = capacidadDeProduccion
  method cambiarCapacidadDeProduccion(unaCapacidad){
    capacidadDeProduccion = unaCapacidad
  }

  method esBueno(){
    return capacidadDeProduccion > nivelParaProduccionDeHuerta
  }

  method recibirConsequenciasAtaque(unaPlaga){
    var reduccion = unaPlaga.daño() / 10
    if (unaPlaga.transmitenEnfermedades()) {
      reduccion += 10
    }
    capacidadDeProduccion -= reduccion
  }
}

class Mascota{
  var nivelDeSalud

  method nivelDeSalud() = nivelDeSalud
  method cambiarNivelDeSalud(unNivel){
    nivelDeSalud = unNivel
  }

  method esBueno(){
    return nivelDeSalud > 250
  }

  method recibirConsequenciasAtaque(unaPlaga) {
    if (unaPlaga.transmitenEnfermedades()) {
      nivelDeSalud -= unaPlaga.daño()
    }
  }
}

class Plagas{
  var poblacion
  

  method daño()
  method poblacion() = poblacion
  method cambiarPoblacion(unNumero){
    poblacion = unNumero
  }

  method transmitenEnfermedades(){
    return poblacion >= 10
  }

  method atacarElemento(unElemento){
    unElemento.recibirConsequenciasAtaque()
  }

  method recibirBeneficiosDelAtaque(){
    poblacion += poblacion * 0.1
  }
}

class Cucarachas inherits Plagas{
  var pesoPromedio

  method pesoPromedio() = pesoPromedio
  method cambiarPesoPromedio(unNumero){
    pesoPromedio = unNumero
  }

  override method daño(){
    return poblacion / 2
  }

  override method transmitenEnfermedades(){
    return super() && pesoPromedio >= 10
  }

  override method recibirBeneficiosDelAtaque(){
    super() 
    pesoPromedio + 2
  }

  
}

class Pulgas inherits Plagas{
  override method daño(){
    return poblacion * 2
  }


}

class Garrapatas inherits Plagas{
  override method daño(){
    return poblacion * 2 
  }

  override method recibirBeneficiosDelAtaque(){
    poblacion += poblacion * 0.2
  }

  
}

class Mosquitos inherits Plagas{
  override method daño(){
    return poblacion
  }

  override method transmitenEnfermedades(){
    return super() && (poblacion % 3 == 0)
  }

  
}