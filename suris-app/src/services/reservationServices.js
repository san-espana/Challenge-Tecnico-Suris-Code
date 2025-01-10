import axios from "axios";

const url = "https://localhost:7237/api/reservations";

const getAllReservations = async () => {
    try{
        const res = await axios.get(url)

        if(res.data){
        console.log("Existing Reservations Response:", res.data)
        return res.data
        } else {
        console.log("No Existing Reservations")
        }
    }
    catch (err) {
        console.log("There's been an error while fetching the Existing Reservations", err)
    } 
}

const getClientReservations = async (clientName) => {
    try{
        const res = await axios.get(url + "/client/" + clientName)

        if(res.data){
        console.log("Existing Client Reservations Response:", res.data)
        return res.data
        } else {
        console.log("No Existing Client Reservations")
        }
    }
    catch (err) {
        console.log("There's been an error while fetching the Client Existing Reservations", err)
    } 
}

const getAllServices = async () => {
    try{
          const res = await axios.get(url + "/services")
     
          if(res.data){
            console.log("All Services Response:", res.data)
            return res.data
          } else {
            console.log("No Services found")
          }
        }
        catch (err) {
          console.log("There's been an error while fetching the Services", err)
        }
}


const addNewReservation = async (payload) => {
    try {
      const response = await axios.post(url, payload);
      console.log("Response from server:", response.data);
      return true
    } catch (error) {
      console.error("Error posting data:", error);
      return false
    }
  }

export {getAllReservations, getAllServices, addNewReservation, getClientReservations}