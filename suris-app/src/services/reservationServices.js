import axios from "axios";

const url = "https://localhost:7237/api/reservations";

const getAllReservations = async () => {
    try{
        const res = await axios.get(url)

        if(res.data){
        console.log("Reservas:", res.data)
        return res.data
        } else {
        console.log("No se encontraron reservas")
        }
    }
    catch (err) {
        console.log("ERROR getAllReservations: ", err)
    } 
}

const getClientReservations = async (clientName) => {
    try{
        const res = await axios.get(url + "/client/" + clientName)

        if(res.data){
        console.log("Reservas del cliente:", res.data)
        return res.data
        } else {
        console.log("No se encontraron reservas a nombre de " + clientName)
        }
    }
    catch (err) {
        console.log("ERROR getClientReservations: ", err)
    } 
}

const getAllServices = async () => {
    try{
          const res = await axios.get(url + "/services")
     
          if(res.data){
            console.log("Servicios:", res.data)
            return res.data
          } else {
            console.log("No se encontraron servicios")
          }
        }
        catch (err) {
          console.log("ERROR getAllServices: ", err)
        }
}

const addNewReservation = async (payload) => {
    try {
      const response = await axios.post(url, payload);
      console.log("Reserva creada:", response.data);
      return true
    } catch (error) {
      console.error("ERROR addNewReservation: ", error);
      return false
    }
  }

export {getAllReservations, getAllServices, addNewReservation, getClientReservations}