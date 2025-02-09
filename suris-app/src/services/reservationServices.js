import axios from "axios";

const url = "https://localhost:7237/api/v2/reservations";

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
      return { success: true, message: "Reserva creada con éxito!" };

    } catch (error) {
      let errorMessage = "Error desconocido, por favor intenta nuevamente.";

      if (error.response.data) {
        errorMessage = error.response.data || "Hubo un problema con la solicitud.";
      } else if (error.response.status) {
        errorMessage = `Error del servidor: ${error.response.status}`;
      }

    console.error("ERROR addNewReservation: ", errorMessage);
    return { success: false, message: errorMessage };
    }
  }

export {getAllReservations, getAllServices, addNewReservation, getClientReservations}